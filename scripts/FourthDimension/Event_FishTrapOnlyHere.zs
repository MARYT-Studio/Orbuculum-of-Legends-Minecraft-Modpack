// Events
import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent;
import crafttweaker.api.event.block.MCBlockPlaceEvent;
import crafttweaker.api.event.block.MCBlockBreakEvent;

// Datatypes
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.IData;

val debug = true;

if (!debug) {
    // Interact Restrict
    CTEventManager.register<MCRightClickBlockEvent>((event) => {
        var nullablePlayer as MCPlayerEntity? = event.player;
        if (nullablePlayer != null) {
            var player as MCPlayerEntity = nullablePlayer as MCPlayerEntity;
            var world = player.world;
            if (!world.remote) {
                var block = world.getBlockState(event.blockPos).block;
                if (<block:fishtraps:wooden_fish_trap>.matchesBlock(block) ||
                    <block:fishtraps:iron_fish_trap>.matchesBlock(block) ||
                    <block:fishtraps:diamond_fish_trap>.matchesBlock(block)) {
                    if (world.dimension != "orbuculum_of_legends:ocean") {
                        player.sendMessage("\u00A7c\u00A7l\u53EA\u6709\u5728\u7B2C\u56DB\u5C42\u7684\u6D77\u6D0B\u4E16\u754C\u4E2D\u53EF\u4EE5\u4F7F\u7528\u6E14\u6805\u3002");
                        event.cancel();
                    }
                    var hasSucceededStageThree as IData? = player.getPersistentData().getAt("SucceedInStageThree");
                    if (hasSucceededStageThree == null || hasSucceededStageThree.asBoolean() == false) {
                        player.sendMessage("\u00A7c\u00A7l\u4F60\u5C1A\u672A\u638C\u63E1\u6253\u9C7C\u4EBA\u7684\u77E5\u8BC6\uFF0C\u65E0\u6CD5\u4F7F\u7528\u8FD9\u4E2A\u7269\u54C1");
                        event.cancel();
                    }                    
                }
            }
        }
    });

    // Place Restrict
    CTEventManager.register<MCBlockPlaceEvent>((event) => {
        var entity = event.entity;
        if (entity is MCPlayerEntity) {
            var player as MCPlayerEntity = entity as MCPlayerEntity;
            var world = player.world;
            if (!world.remote) {
                var block = event.placedBlock.block;
                if (<block:fishtraps:wooden_fish_trap>.matchesBlock(block) ||
                    <block:fishtraps:iron_fish_trap>.matchesBlock(block) ||
                    <block:fishtraps:diamond_fish_trap>.matchesBlock(block)) {
                        if (world.dimension != "orbuculum_of_legends:ocean") {
                            player.sendMessage("\u00A7c\u00A7l\u53EA\u6709\u5728\u7B2C\u56DB\u5C42\u7684\u6D77\u6D0B\u4E16\u754C\u4E2D\u53EF\u4EE5\u4F7F\u7528\u6E14\u6805\u3002");
                            event.cancel();
                        }
                        var hasSucceededStageThree as IData? = player.getPersistentData().getAt("SucceedInStageThree");
                        if (hasSucceededStageThree == null || hasSucceededStageThree.asBoolean() == false) {
                            player.sendMessage("\u00A7c\u00A7l\u4F60\u5C1A\u672A\u638C\u63E1\u6253\u9C7C\u4EBA\u7684\u77E5\u8BC6\uFF0C\u65E0\u6CD5\u4F7F\u7528\u8FD9\u4E2A\u7269\u54C1");
                            event.cancel();
                        }
                    }
            }
        }
    });

    // Break Restrict
    CTEventManager.register<MCBlockBreakEvent>((event) => {
        var player = event.player;
        var world = player.world;
        if (!player.fake && !world.remote) {
            var block = event.state.block;
            if (<block:fishtraps:wooden_fish_trap>.matchesBlock(block) ||
                <block:fishtraps:iron_fish_trap>.matchesBlock(block) ||
                <block:fishtraps:diamond_fish_trap>.matchesBlock(block)) {
                    if (world.dimension != "orbuculum_of_legends:ocean") {
                        player.sendMessage("\u00A7c\u00A7l\u53EA\u6709\u5728\u7B2C\u56DB\u5C42\u7684\u6D77\u6D0B\u4E16\u754C\u4E2D\u53EF\u4EE5\u4F7F\u7528\u6E14\u6805\u3002");
                        event.cancel();
                    }
                    var hasSucceededStageThree as IData? = player.getPersistentData().getAt("SucceedInStageThree");
                    if (hasSucceededStageThree == null || hasSucceededStageThree.asBoolean() == false) {
                        player.sendMessage("\u00A7c\u00A7l\u4F60\u5C1A\u672A\u638C\u63E1\u6253\u9C7C\u4EBA\u7684\u77E5\u8BC6\uFF0C\u65E0\u6CD5\u4F7F\u7528\u8FD9\u4E2A\u7269\u54C1");
                        event.cancel();
                    }
                }
        }
    });
}
