PrefabFiles = 
{
	"compost_box"
}

Assets = 
{
	Asset( "IMAGE", "minimap/composter.tex" ),
    Asset( "ATLAS", "minimap/composter.xml" ),
    Asset("IMAGE", "images/inventoryimages/composter.tex"),
	Asset("ATLAS", "images/inventoryimages/composter.xml"),
}

AddMinimapAtlas("minimap/composter.xml")

local TUNING = GLOBAL.TUNING

GLOBAL.TUNING.COMPOSTER = {}
GLOBAL.TUNING.COMPOSTER.DECAYSINTO = GetModConfigData("decaysinto")

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH



GLOBAL.STRINGS.NAMES.COMPOSTER = "Composter"

STRINGS.RECIPE_DESC.COMPOSTER = "Get that Fertalizer!"

GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.COMPOSTER = "It smells"

local composter = GLOBAL.Recipe("composter",{ Ingredient("cutgrass", 6), Ingredient("poop", 2), Ingredient("boards", 2) }, RECIPETABS.FARM, TECH.SCIENCE_ONE, "composter_placer" )
composter.atlas = "images/inventoryimages/composter.xml"