import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.tileentity.MCTileEntity;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.ListData;
import stdlib.List;

import crafttweaker.api.item.ItemStack;
import crafttweaker.api.item.IItemStack;

val recipesDictionary as string[][]= [
    // Group 1
    // CAIPIRINHA
    ["tropicraft:lime", "minecraft:sugar_cane", "minecraft:water_bucket"],
    // ORANGEADE
    ["tropicraft:orange", "minecraft:sugar", "minecraft:water_bucket"],
    // LEMONADE
    ["tropicraft:lemon", "minecraft:sugar", "minecraft:water_bucket"],

    // Group 2
    // PINA_COLADA
    ["tropicraft:pineapple_cubes", "tropicraft:coconut_chunk"],
    ["tropicraft:pineapple_cubes", "tropicraft:coconut"],
    ["tropicraft:pineapple", "tropicraft:coconut_chunk"],
    ["tropicraft:pineapple", "tropicraft:coconut"],
    // LIMEADE
    ["tropicraft:lime", "minecraft:sugar", "minecraft:water_bucket"],
    // BLACK_COFFEE
    ["tropicraft:roasted_coffee_bean", "minecraft:water_bucket"],
    
    // Group 3
    // MAI_TAI
    ["tropicraft:orange", "tropicraft:lime", "minecraft:water_bucket"],
    // COCONUT_WATER
    ["tropicraft:coconut", "minecraft:water_bucket"]
];

val maskDictionary as IItemStack[][] = [
    // Mask Group Bestia, like Juice, Recipe Group 1
    [
        <item:tropicraft:ashen_mask_square_horn>,
        <item:tropicraft:ashen_mask_screw_attack>,
        <item:tropicraft:ashen_mask_warthog>,
        <item:tropicraft:ashen_mask_horn_monkey>,
        <item:tropicraft:ashen_mask_bat_boy>
    ],
    // Mask Group Enigma, like Coffee, Recipe Group 2 
    [
        <item:tropicraft:ashen_mask_the_brain>,
        <item:tropicraft:ashen_mask_the_heart>,
        <item:tropicraft:ashen_mask_headinator>,
        <item:tropicraft:ashen_mask_enigma>
    ],
    // Mask Group Philosophus, like fresh feeling of Coconut, Recipe Group 3
    [
        <item:tropicraft:ashen_mask_oblongatron>,
        <item:tropicraft:ashen_mask_invader>,
        <item:tropicraft:ashen_mask_mojo>,
        <item:tropicraft:ashen_mask_square_zord>
    ]
];

CTEventManager.register<MCRightClickBlockEvent>((event) => {
    
    // First Part: get needed values

    var playerNullable as MCPlayerEntity? = event.player;
    if (playerNullable == null) return;

    var player as MCPlayerEntity = playerNullable;
    var world = player.world;
    if (world.remote) return;

    var pos = event.blockPos;
    var blockState = world.getBlockState(pos);

    // Second Part: check the status of mixer, see if it its recipe is fulfilled

    if <block:tropicraft:drink_mixer>.matchesBlock(blockState.block) {
        var mixerTileEntityNullable as MCTileEntity? = world.getTileEntity(pos);
        if (mixerTileEntityNullable != null) {
            var data  = mixerTileEntityNullable.data;
            var ingredient0 as IData? = data.getAt("Ingredient0");
            if (ingredient0 == null) return;
            var ingredient1 as IData? = data.getAt("Ingredient1");
            if (ingredient1 == null) return;
            var ingredient2 as IData? = data.getAt("Ingredient2");
            if (ingredient2 == null) return;
            
            var ingredientMap0 as IData[string] = ingredient0.asMap();
            var ingredientMap1 as IData[string] = ingredient1.asMap();
            var ingredientMap2 as IData[string] = ingredient2.asMap();

            var ingrNames = new List<string>();

            ingrNames.add(ingredientMap0["id"].getString());
            ingrNames.add(ingredientMap1["id"].getString());
            ingrNames.add(ingredientMap2["id"].getString());
            
            var index as int = 0;
            // For every recipe
            for recipe in recipesDictionary {
                var flag as int = 0;
                for ingr in recipe {
                    if (ingr in ingrNames) {flag += 1;}
                }
                if (flag == recipe.length as int) break;
                index += 1;
            }
            var recipeGroup as string = "ask_for_recipe";
            switch (index) {
                case 0:
                case 1:
                case 2:
                    recipeGroup = "mixer_recipe_group_1";
                    break;
                case 3:
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                    recipeGroup = "mixer_recipe_group_2";
                    break;
                case 9:
                case 10:
                    recipeGroup = "mixer_recipe_group_3";
                    break;
                default:
                    break;
            }

            // Third Part: Control Logic
            // If recipe is not fulfilled, player ask for recipe
            // In this case, the item player is holding is neglected, but check player's head armor.

            switch (recipeGroup) {
                case "ask_for_recipe":
                    var armorList as List<ItemStack> = player.getArmorInventoryList();
                    var i as int = 0;
                    for maskGroup in maskDictionary {
                        if (armorList[3].asIItemStack().definition.defaultInstance in maskGroup) {
                            break;
                        }
                        i += 1;
                    }
                    switch (i) {
                        case 0:
                            if (player.hasGameStage("mixer_recipe_group_1")) {
                                player.sendMessage("\u54C8\u54C8\uFF0C\u5C0F\u9B3C\uFF0C\u4F60\u5DF2\u7ECF\u4E86\u89E3\u4E86\u731B\u517D\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u5566\u3002");
                            } else {
                                player.sendMessage("\u8FD9\u662F\u731B\u517D\u6C0F\u65CF\u7684\u9762\u5177\uFF0C\u770B\u6765\u4F60\u5C5E\u4E8E\u731B\u517D\u6C0F\u65CF\uFF1A\u4EE5\u51F6\u731B\u51CC\u5389\u7684\u8FDB\u653B\u4E3A\u50B2\u7684\u6C0F\u65CF\u3002");
                                player.sendMessage("\u5949\u90A3\u540D\u53F7\u4E0D\u53EF\u547C\u5524\u7684\u795E\u660E\u4E0E\u914B\u957F\u9CD5\u9C7C\u7684\u540D\u4E49\uFF0C\u6211\u5C06\u731B\u517D\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u4F20\u6388\u7ED9\u4F60\u3002");
                                player.sendMessage("\u8FD9\u4E9B\u9178\u751C\u53EF\u53E3\u7684\u679C\u6C41\uFF0C\u8DB3\u4EE5\u629A\u6170\u6211\u4EEC\u90E8\u65CF\u7684\u5404\u4F4D\u6218\u58EB\uFF01");
                            }
                            player.addGameStage("mixer_recipe_group_1");
                            world.asServerWorld().server.executeCommand(
                                "title " + player.name as string + " title {\"text\":\"\u4F60\u5DF2\u7ECF\u638C\u63E1\u4E86\"}", true
                            );
                            world.asServerWorld().server.executeCommand(
                                "title " + player.name as string + " subtitle {\"text\":\"\u731B\u517D\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\"}", true
                            );
                            break;
                        case 1:
                            if (player.hasGameStage("mixer_recipe_group_2")) {
                                player.sendMessage("\u54C8\u54C8\uFF0C\u5C0F\u9B3C\uFF0C\u4F60\u5DF2\u7ECF\u4E86\u89E3\u4E86\u5965\u79D8\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u5566\u3002");
                            } else {
                                player.sendMessage("\u8FD9\u662F\u5965\u79D8\u6C0F\u65CF\u7684\u9762\u5177\uFF0C\u770B\u6765\u4F60\u5C5E\u4E8E\u5965\u79D8\u6C0F\u65CF\uFF1A\u4EE5\u6D1E\u5BDF\u4E07\u7269\u7684\u7406\u6027\u8457\u79F0\u7684\u6C0F\u65CF\u3002");
                                player.sendMessage("\u5949\u90A3\u540D\u53F7\u4E0D\u53EF\u547C\u5524\u7684\u795E\u660E\u4E0E\u914B\u957F\u9CD5\u9C7C\u7684\u540D\u4E49\uFF0C\u6211\u5C06\u5965\u79D8\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u4F20\u6388\u7ED9\u4F60\u3002");
                                player.sendMessage("\u8FD9\u4E9B\u63D0\u795E\u9192\u8111\u7684\u5496\u5561\uFF0C\u8DB3\u4EE5\u632F\u594B\u6211\u4EEC\u90E8\u65CF\u7684\u5404\u4F4D\u54F2\u4EBA\uFF01");
                            }
                            player.addGameStage("mixer_recipe_group_2");
                            world.asServerWorld().server.executeCommand(
                                "title " + player.name as string + " title {\"text\":\"\u4F60\u5DF2\u7ECF\u638C\u63E1\u4E86\"}", true
                            );
                            world.asServerWorld().server.executeCommand(
                                "title " + player.name as string + " subtitle {\"text\":\"\u5965\u79D8\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\"}", true
                            );
                            break;
                        case 2:
                            if (player.hasGameStage("mixer_recipe_group_3")) {
                                player.sendMessage("\u54C8\u54C8\uFF0C\u5C0F\u9B3C\uFF0C\u4F60\u5DF2\u7ECF\u4E86\u89E3\u4E86\u7B56\u58EB\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u5566\u3002");
                            } else {
                                player.sendMessage("\u8FD9\u662F\u7B56\u58EB\u6C0F\u65CF\u7684\u9762\u5177\uFF0C\u770B\u6765\u4F60\u5C5E\u4E8E\u7B56\u58EB\u6C0F\u65CF\uFF1A\u4EE5\u8FD0\u7B79\u5E37\u5E44\u7684\u8C0B\u7565\u89C1\u957F\u7684\u6C0F\u65CF\u3002");
                                player.sendMessage("\u5949\u90A3\u540D\u53F7\u4E0D\u53EF\u547C\u5524\u7684\u795E\u660E\u4E0E\u914B\u957F\u9CD5\u9C7C\u7684\u540D\u4E49\uFF0C\u6211\u5C06\u7B56\u58EB\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u4F20\u6388\u7ED9\u4F60\u3002");
                                player.sendMessage("\u8FD9\u6E05\u723D\u89E3\u6E34\u7684\u6930\u5B50\u6C34\uFF0C\u8DB3\u4EE5\u6170\u52B3\u6211\u4EEC\u90E8\u65CF\u7684\u5404\u4F4D\u8C0B\u58EB\uFF01");
                            }
                            player.addGameStage("mixer_recipe_group_3");
                            world.asServerWorld().server.executeCommand(
                                "title " + player.name as string + " title {\"text\":\"\u4F60\u5DF2\u7ECF\u638C\u63E1\u4E86\"}", true
                            );
                            world.asServerWorld().server.executeCommand(
                                "title " + player.name as string + " subtitle {\"text\":\"\u7B56\u58EB\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\"}", true
                            );
                            break;
                        default:
                            if (player.hasGameStage("mixer_recipe_group_1") || player.hasGameStage("mixer_recipe_group_2") || player.hasGameStage("mixer_recipe_group_3")) {
                                player.sendMessage("\u54C8\u54C8\uFF0C\u4F60\u597D\uFF0C\u5C0F\u9B3C\uFF01\u4E0D\u59A8\u5728\u6211\u8FD9\u559D\u4E0A\u4E00\u676F\uFF0C\u542C\u6211\u8BB2\u8BB2\u90E8\u65CF\u7684\u6545\u4E8B\u5427\u3002");

                                // TODO: Randomly talking
                            } else {
                                player.sendMessage("\u4F60\u4E0D\u5C5E\u4E8E\u6211\u4EEC\u90E8\u65CF\u7684\u4EFB\u4F55\u4E00\u4E2A\u6C0F\u65CF\uFF0C\u6211\u4E0D\u4F1A\u628A\u996E\u6599\u79D8\u65B9\u544A\u77E5\u5916\u4EBA\uFF01\u8BF7\u56DE\u5427\uFF01");
                                player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u5148\u5C06\u996E\u6599\u673A\u4E0A\u7684\u4E1C\u897F\u53D6\u4E0B\uFF0C\u6234\u4E0A\u6C0F\u65CF\u9762\u5177\uFF0C\u518D\u8BD5\u8BD5\u8BE2\u95EE\u996E\u6599\u673A\u5173\u4E8E\u996E\u6599\u914D\u65B9\u7684\u4E8B\u3002");
                            }
                    }
                    break;
                case "mixer_recipe_group_1":
                    if (<item:tropicraft:bamboo_mug>.matches(event.itemStack)) {
                        if (!(player.hasGameStage("mixer_recipe_group_1"))) {
                            player.sendMessage("\u4F60\u5E76\u975E\u731B\u517D\u6C0F\u65CF\u7684\u4E00\u5458\uFF0C\u6211\u53EA\u628A\u731B\u517D\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u4F20\u6388\u7ED9\u81EA\u5DF1\u4EBA\uFF01\u8BF7\u56DE\u5427\uFF01");
                            player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u5148\u5C06\u996E\u6599\u673A\u4E0A\u7684\u4E1C\u897F\u53D6\u4E0B\uFF0C\u6234\u4E0A\u6C0F\u65CF\u9762\u5177\uFF0C\u518D\u8BD5\u8BD5\u8BE2\u95EE\u996E\u6599\u673A\u5173\u4E8E\u996E\u6599\u914D\u65B9\u7684\u4E8B\u3002");
                            event.cancel();
                        }
                    }
                    break;
                case "mixer_recipe_group_2":
                    if (<item:tropicraft:bamboo_mug>.matches(event.itemStack)) {
                        if (!(player.hasGameStage("mixer_recipe_group_2"))) {
                            player.sendMessage("\u4F60\u5E76\u975E\u5965\u79D8\u6C0F\u65CF\u7684\u4E00\u5458\uFF0C\u6211\u53EA\u628A\u5965\u79D8\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u4F20\u6388\u7ED9\u81EA\u5DF1\u4EBA\uFF01\u8BF7\u56DE\u5427\uFF01");
                            player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u5148\u5C06\u996E\u6599\u673A\u4E0A\u7684\u4E1C\u897F\u53D6\u4E0B\uFF0C\u6234\u4E0A\u6C0F\u65CF\u9762\u5177\uFF0C\u518D\u8BD5\u8BD5\u8BE2\u95EE\u996E\u6599\u673A\u5173\u4E8E\u996E\u6599\u914D\u65B9\u7684\u4E8B\u3002");
                            event.cancel();
                        }
                    }
                    break;
                case "mixer_recipe_group_3":
                if (<item:tropicraft:bamboo_mug>.matches(event.itemStack)) {
                        if (!(player.hasGameStage("mixer_recipe_group_3"))) {
                            player.sendMessage("\u4F60\u5E76\u975E\u7B56\u58EB\u6C0F\u65CF\u7684\u4E00\u5458\uFF0C\u6211\u53EA\u628A\u7B56\u58EB\u6C0F\u65CF\u7684\u996E\u6599\u79D8\u65B9\u4F20\u6388\u7ED9\u81EA\u5DF1\u4EBA\uFF01\u8BF7\u56DE\u5427\uFF01");
                            player.sendMessage("\u00A77[\u4E0D\u77E5\u540D\u7684\u795E\u660E]: \u00A7o\u5148\u5C06\u996E\u6599\u673A\u4E0A\u7684\u4E1C\u897F\u53D6\u4E0B\uFF0C\u6234\u4E0A\u6C0F\u65CF\u9762\u5177\uFF0C\u518D\u8BD5\u8BD5\u8BE2\u95EE\u996E\u6599\u673A\u5173\u4E8E\u996E\u6599\u914D\u65B9\u7684\u4E8B\u3002");
                            event.cancel();
                        }
                    }
                    break;
                default:
                    break;
            }
        }
    }
});
