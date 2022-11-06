#priority 10000
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.util.Random;
import crafttweaker.api.player.MCPlayerEntity;

public enum NewbiePackage {
    SWORD("swords"),
    PICK("picks"),
    AXE("axes"),
    SHOVEL("shovels"),
    HOE("hoes"),
    FOOD("food"),
    MEDIC1("medic1"),
    MEDIC2("medic2");


    this(itemType as string) {
        this.itemType = itemType;
    }

    public var itemType as string;

    public val swords as IItemStack[] = [
        <item:minecraft:stone_sword>, <item:minecraft:iron_sword>, <item:minecraft:diamond_sword>
    ];
    public val picks as IItemStack[] = [
        <item:minecraft:stone_pickaxe>, <item:minecraft:iron_pickaxe>, <item:minecraft:diamond_pickaxe>
    ];
    public val axes as IItemStack[] = [
        <item:minecraft:stone_axe>, <item:minecraft:iron_axe>, <item:minecraft:diamond_axe>
    ];
    public val shovels as IItemStack[] = [
        <item:minecraft:stone_shovel>, <item:minecraft:iron_shovel>, <item:minecraft:diamond_shovel>
    ];
    public val hoes as IItemStack[] = [
        <item:minecraft:stone_hoe>, <item:minecraft:iron_hoe>, <item:minecraft:diamond_hoe>
    ];
    public val food as IItemStack[] = [
        <item:minecraft:cookie> * 64, <item:upgrade_aquatic:cooked_perch> * 12, <item:minecraft:pumpkin_pie> * 16
    ];
    public val medics as IItemStack[] = [
        <item:contenttweaker:moss_clump>, <item:contenttweaker:crude_plaster>
    ];

    public modify(item as IItemStack) as IItemStack {
        var damage as int = 0;
        var itemString as string[] = (item.commandString.split(":"));
        if ("stone" in itemString[2]) {
            return item.withTag(
                {
                    display: {
                        Lore: [
                            '[{"text":"\u4F60\u603B\u662F\u968F\u8EAB\u643A\u5E26\u7740\u7684\u5DE5\u5177\u3002", "color": "gray", "italic":true}]',
                            '[{"text":"\u65B0\u624B\u793C\u5305\u7269\u54C1", "color": "gold", "italic":false}]'
                        ]
                    }
                }
            );
        } else if ("iron" in itemString[2]) {
            return item.withTag(
                {
                    Damage: 129 as int,
                    display: {
                        Lore: [
                            '[{"text":"\u4F60\u603B\u662F\u968F\u8EAB\u643A\u5E26\u7740\u7684\u5DE5\u5177\u3002", "color": "gray", "italic":true}]',
                            '[{"text":"\u65B0\u624B\u793C\u5305\u7269\u54C1", "color": "gold", "italic":false}]'
                        ]
                    }
                }
            );
        } else if ("diamond" in itemString[2]) {
            return item.withTag(
                {
                    Damage: 1460 as int,
                    display: {
                        Lore: [
                            '[{"text":"\u4F60\u603B\u662F\u968F\u8EAB\u643A\u5E26\u7740\u7684\u5DE5\u5177\u3002", "color": "gray", "italic":true}]',
                            '[{"text":"\u65B0\u624B\u793C\u5305\u7269\u54C1", "color": "gold", "italic":false}]'
                        ]
                    }
                }
            );
        } else if ("contenttweaker" in itemString[1]) {
            return item.withTag(
                {
                    display: {
                        Lore: [
                            '[{"text":"\u4F60\u968F\u8EAB\u643A\u5E26\u7684\u836F\u54C1\u3002", "color": "gray", "italic":true}]',
                            '[{"text":"\u65B0\u624B\u793C\u5305\u7269\u54C1", "color": "gold", "italic":false}]'
                        ]
                    }
                }
            );
        } else return item.withTag(
                {
                    display: {
                        Lore: [
                            '[{"text":"\u4F60\u614C\u4E71\u4E2D\u4ECE\u9910\u684C\u4E0A\u6293\u53D6\u7684\u98DF\u7269\u3002", "color": "gray", "italic":true}]',
                            '[{"text":"\u65B0\u624B\u793C\u5305\u7269\u54C1", "color": "gold", "italic":false}]'
                        ]
                    }
                }
            );
    }

    public choice(player as MCPlayerEntity) as IItemStack {
        var rand = player.world.random;
        switch (this.itemType) {
            case "swords":
                return modify(swords[rand.nextInt(swords.length as int)]);
            case "picks":
                return modify(picks[rand.nextInt(picks.length as int)]);
            case "axes":
                return modify(axes[rand.nextInt(axes.length as int)]);
            case "shovels":
                return modify(shovels[rand.nextInt(shovels.length as int)]);
            case "hoes":
                return modify(hoes[rand.nextInt(hoes.length as int)]);
            case "food":
                return modify(food[rand.nextInt(food.length as int)]);
            case "medic1":
                return modify(medics[0] * rand.nextInt(17));
            case "medic2":
                return modify(medics[1] * rand.nextInt(17));
            default:
                return <item:minecraft:air>;
        }
    }
}
