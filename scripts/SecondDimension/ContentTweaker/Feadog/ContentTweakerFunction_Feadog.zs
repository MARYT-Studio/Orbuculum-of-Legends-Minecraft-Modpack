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
    "没有事的话请不要吹它...",
    "它不是玩具..."
];
val refuse_normal as string[] = [
    "我在，有什么新情况？",
    "需要帮忙的话，就说吧。"
];
val accept as string[] = [
    "椰收到了，谢谢。",
    "这个是... 给我的吗？"
];
val another_type as string = "之前的这些喝起来挺不错的，不过，你还有没有其他种类的饮料？";
val succeeded_in_2nd_stage as string ="我不能离开被封印的地方，前面的路就要你自己走了。\n真的很谢谢你。在我们相处的这段时间，你教会了我很多东西，\n让我重新理解了什么是“朋友”。\n这个哨笛留给你做纪念，希望你再一次吹响它的时候，也会想起我。\n我们一定能离开这里的，加油，我相信你！";


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
                    player.sendMessage("§7[不知名的神明]: §o还需收集的椰：（0/16）。");
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
                            player.sendMessage("§7[不知名的神明]: 你已经收集了足够的椰，任务完成啦！");
                            player.give(<item:tropicraft:coconut> * (coco_amount - 16));
                            player.updatePersistentData(
                                {
                                    "secondDimTaskNBT": {"coco_amount": 16}
                                }
                            );
                            return stack;
                        }
                        player.sendMessage(refuse_bad[worldIn.random.nextInt(refuse_bad.length as int)]);
                        player.sendMessage("§7[不知名的神明]: §o还需收集的椰：（" + coco_amount + "/16）。");
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
                                player.sendMessage("§7[不知名的神明]: 你已经收集了足够的椰，任务完成啦！");
                                player.give(<item:tropicraft:coconut> * (cocoAmount - 16));
                                player.updatePersistentData(
                                    {
                                        "secondDimTaskNBT": {"coco_amount": 16}
                                    }
                                );
                                return stack;
                            }
                            player.sendMessage("§7[不知名的神明]: §o还需收集的椰：（" + currentCocoAmountNullable.asNumber().getInt() + "/16）。");
                        }
                    }
                }
            } else if (!player.hasGameStage("give_me_tea")) {
                
            }
            else {
                player.sendMessage(refuse_normal[worldIn.random.nextInt(refuse_normal.length as int)]);
                return stack;
            }
        }
    }
    return stack;
});
