#loader crafttweaker
import crafttweaker.api.util.ActionResultType;
import crafttweaker.api.item.UseAction;
// ContentTweaker Packages
import mods.contenttweaker.item.advance.CoTItemAdvanced;
// Utils
import crafttweaker.api.util.Random;
// Data Types
import crafttweaker.api.data.IData;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IntData;
import crafttweaker.api.entity.MCItemEntity;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.util.BlockPos;
// List
import stdlib.List;

// Texts
val refuse_bad as string[] = [
    "\u6CA1\u6709\u4E8B\u7684\u8BDD\u8BF7\u4E0D\u8981\u5439\u5B83...",
    "\u5B83\u4E0D\u662F\u73A9\u5177..."
];
val refuse_normal as string[] = [
    "\u6211\u5728\uFF0C\u6709\u4EC0\u4E48\u65B0\u60C5\u51B5\uFF1F",
    "\u9700\u8981\u5E2E\u5FD9\u7684\u8BDD\uFF0C\u5C31\u8BF4\u5427\u3002"
];
val accept as string[] = [
    "\u6930\u6536\u5230\u4E86\uFF0C\u8C22\u8C22\u3002",
    "\u8FD9\u4E2A\u662F... \u7ED9\u6211\u7684\u5417\uFF1F"
];
val another_type as string = "\u4E4B\u524D\u7684\u8FD9\u4E9B\u559D\u8D77\u6765\u633A\u4E0D\u9519\u7684\uFF0C\u4E0D\u8FC7\uFF0C\u4F60\u8FD8\u6709\u6CA1\u6709\u5176\u4ED6\u79CD\u7C7B\u7684\u996E\u6599\uFF1F";
val succeeded_in_2nd_stage as string ="\u6211\u4E0D\u80FD\u79BB\u5F00\u88AB\u5C01\u5370\u7684\u5730\u65B9\uFF0C\u524D\u9762\u7684\u8DEF\u5C31\u8981\u4F60\u81EA\u5DF1\u8D70\u4E86\u3002\n\u771F\u7684\u5F88\u8C22\u8C22\u4F60\u3002\u5728\u6211\u4EEC\u76F8\u5904\u7684\u8FD9\u6BB5\u65F6\u95F4\uFF0C\u4F60\u6559\u4F1A\u4E86\u6211\u5F88\u591A\u4E1C\u897F\uFF0C\n\u8BA9\u6211\u91CD\u65B0\u7406\u89E3\u4E86\u4EC0\u4E48\u662F\u201C\u670B\u53CB\u201D\u3002\n\u8FD9\u4E2A\u54E8\u7B1B\u7559\u7ED9\u4F60\u505A\u7EAA\u5FF5\uFF0C\u5E0C\u671B\u4F60\u518D\u4E00\u6B21\u5439\u54CD\u5B83\u7684\u65F6\u5019\uFF0C\u4E5F\u4F1A\u60F3\u8D77\u6211\u3002\n\u6211\u4EEC\u4E00\u5B9A\u80FD\u79BB\u5F00\u8FD9\u91CC\u7684\uFF0C\u52A0\u6CB9\uFF0C\u6211\u76F8\u4FE1\u4F60\uFF01";


val feadog as CoTItemAdvanced = <advanceditem:feadog>;

feadog.setItemUseAction((stack) => {
    return UseAction.BLOCK;
}).setOnItemRightClick((item, playerEntity, world, hand) => {
    return ActionResultType.SUCCESS;
}).setOnItemUseFinish((stack, worldIn, entityLiving) => {
    if (!worldIn.remote) {
        if (entityLiving is MCPlayerEntity) {
            // If used by player, everytime when useFinish, play sound
            var player as MCPlayerEntity = entityLiving as MCPlayerEntity;
            worldIn.asServerWorld().server.executeCommand(
                "execute at " + player.name as string + " run playsound minecraft:block.beacon.activate block " + player.name as string + " ~ ~ ~ 1.0 2.0", true
            );

            // Task logic
            // give me coco task
            if (!player.hasGameStage("give_me_coco")) {
                var secondDimTaskNBT as IData? = player.getPersistentData().getAt("secondDimTaskNBT");
                // If task NBT is null, preset Player's NBT
                if (secondDimTaskNBT == null) {
                    player.updatePersistentData(
                        {
                            "secondDimTaskNBT": {
                                "coco_amount": 0 as int,
                                "tea_task": false as bool,
                                "drinks_group_1": false as bool,
                                "drinks_group_2": false as bool,
                                "drinks_group_3": false as bool,
                                "no_alchohol": 0 as int
                            }
                        }
                    );
                    player.sendMessage(refuse_bad[worldIn.random.nextInt(refuse_bad.length as int)]);
                    player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u8FD8\u9700\u6536\u96C6\u7684\u6930\uFF1A\uFF080/16\uFF09\u3002");
                    return stack;
                } else {
                    var coco_amount as int = 0;
                    var cocoAmountNullable as IData? = player.getPersistentData().getData<MapData>("secondDimTaskNBT").getAt("coco_amount");
                    if (cocoAmountNullable == null) return stack;
                    coco_amount = cocoAmountNullable.asNumber().getInt();
                    var newCocoAmount = coco_amount;
                    var pos = player.position;
                    var pos1 = pos.add(new BlockPos(-3, -1, -3));
                    var pos2 = pos.add(new BlockPos(3, 1, 3));
                    var targetList as List<MCItemEntity> = player.world.getEntitiesInAreaExcluding(
                        player, 
                        (entityIn) => (entityIn is MCItemEntity && <item:tropicraft:coconut>.matches((entityIn as MCItemEntity).item)),
                        pos1,
                        pos2
                    );
                    for target in targetList {
                        newCocoAmount += target.item.amount;
                        target.remove();
                    }
                    if (newCocoAmount == coco_amount) {
                        if (coco_amount >= 16) {
                            player.addGameStage("give_me_coco");
                            player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u4F60\u5DF2\u7ECF\u6536\u96C6\u4E86\u8DB3\u591F\u7684\u6930\uFF0C\u4EFB\u52A1\u5B8C\u6210\u5566\uFF01");
                            player.give(<item:tropicraft:coconut> * (coco_amount - 16));
                            player.updatePersistentData(
                                {
                                    "secondDimTaskNBT": {"coco_amount": 16}
                                }
                            );
                            return stack;
                        }
                        player.sendMessage(refuse_bad[worldIn.random.nextInt(refuse_bad.length as int)]);
                        player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u8FD8\u9700\u6536\u96C6\u7684\u6930\uFF1A\uFF08" + coco_amount + "/16\uFF09\u3002");
                    } else {
                        player.updatePersistentData(
                            {
                                "secondDimTaskNBT": {"coco_amount": newCocoAmount}
                            }
                        );
                        var currentCocoAmountNullable as IData? = player.getPersistentData().getData<MapData>("secondDimTaskNBT").getAt("coco_amount");
                        if (cocoAmountNullable != null) {
                            var cocoAmount as int = cocoAmountNullable.asNumber().getInt();
                            if (cocoAmount >= 16) {
                                player.addGameStage("give_me_coco");
                                player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u4F60\u5DF2\u7ECF\u6536\u96C6\u4E86\u8DB3\u591F\u7684\u6930\uFF0C\u4EFB\u52A1\u5B8C\u6210\u5566\uFF01");
                                player.give(<item:tropicraft:coconut> * (cocoAmount - 16));
                                player.updatePersistentData(
                                    {
                                        "secondDimTaskNBT": {"coco_amount": 16}
                                    }
                                );
                                return stack;
                            }
                            player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u8FD8\u9700\u6536\u96C6\u7684\u6930\uFF1A\uFF08" + currentCocoAmountNullable.asNumber().getInt() + "/16\uFF09\u3002");
                        }
                    }
                }
            } else if (!player.hasGameStage("give_me_tea")) {
                
            }
        }
    }
    return stack;
});
