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
val another_type as string = "之前的这些喝起来挺不错的，不过，你有没有其他种类的酒？";
val succeeded_in_2nd_stage as string ="我不能离开被封印的地方，前面的路就要你自己走了。\n真的很谢谢你。在我们相处的这段时间，你教会了我很多东西，\n让我重新理解了什么是“朋友”。\n这个哨笛留给你做纪念，希望你再一次吹响它的时候，也会想起我。\n我们一定能离开这里的，加油，我相信你！";


val feadog as CoTItemAdvanced = <advanceditem:feadog>;

feadog.setItemUseAction((stack) => {
    return UseAction.BLOCK;
}).setOnItemRightClick((item, playerEntity, world, hand) => {
    return ActionResultType.SUCCESS;
}).setOnItemUseFinish((stack, worldIn, entityLiving) => {
    if (!worldIn.remote) {
        if (entityLiving is MCPlayerEntity) {
            var player as MCPlayerEntity = entityLiving as MCPlayerEntity;
            worldIn.asServerWorld().server.executeCommand(
                "execute at " + player.name as string + " run playsound minecraft:block.beacon.activate block " + player.name as string + " ~ ~ ~ 1.0 2.0", true
            );
        }
        if (!player.hasGameStage("give_me_coco")) {
            var secondDimTaskNBT as IData? = player.getPersistentData().getAt("secondDimTaskNBT");
            // Preset Player NBT
            if (secondDimTaskNBT == null) {
                player.updatePersistentData(
                    {
                        "secondDimTaskNBT": {
                            "coco_amount": 0 as int,
                            "tea_task": false as bool
                            "drinks_group_1": false as bool,
                            "drinks_group_2": false as bool,
                            "drinks_group_3": false as bool,
                            "no_alchohol": 0 as int
                        }
                    }
                );
                player.sendMessage()
                return stack;
            }

        }
    }
    return stack;
});
