import stdlib.List;
val enable as bool = false;

if(enable) {
    var previousString = "";
    var output as List<string> = new List<string>();
    var allHarvestLevel as List<string> = new List<string>();
    for blockstate in game.blockStates {
        var hlstring as string = "" + blockstate.harvestLevel;
        if(allHarvestLevel.indexOf(hlstring) == -1 as usize) {
            allHarvestLevel.add(hlstring);
        }
    }
    for i in 0 .. allHarvestLevel.length {
        output.add("# Harvest Level " + (i - 1) + " Block List\n" + "| Block BEP | Harvest Level |\n| ----------- | ----------- |\n");
    }
    for blockstate in game.blockStates {
        var blockString = blockstate.block.commandString;
        var miningLevel = blockstate.harvestLevel;
        if(!(blockString == previousString)) {
            output[miningLevel + 1] = output[miningLevel + 1] + "| " + blockString + " | " + miningLevel + " |\n";
            previousString = blockString;
        }
    }
    var fullOutput as string = "";
    for i in 0 .. allHarvestLevel.length {
        fullOutput += output[i];
        fullOutput += "\n";
    }
    println(fullOutput);
}