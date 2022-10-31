#loader crafttweaker
import crafttweaker.api.util.ActionResultType;
import crafttweaker.api.item.UseAction;
import crafttweaker.api.player.MCPlayerEntity;

import mods.contenttweaker.item.advance.CoTItemAdvanced;

import crafttweaker.api.util.Random;

import crafttweaker.api.data.IData;

// 1 second = 20 ticks
val second as int = 20;

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
val another_type as string = "\u4E4B\u524D\u7684\u8FD9\u4E9B\u559D\u8D77\u6765\u633A\u4E0D\u9519\u7684\uFF0C\u4E0D\u8FC7\uFF0C\u4F60\u6709\u6CA1\u6709\u5176\u4ED6\u79CD\u7C7B\u7684\u9152\uFF1F";
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
                    return stack;
                } else {
                    // Not null, real task logic
                    // TODO
                }
            }
        }
    }
    return stack;
});
