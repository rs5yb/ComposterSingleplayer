name = "A composter"
description = "Let the fertalizer roll in!"
author = "Blazerdrive09 and Jd5team"
version = "1.3.1"

forumthread = ""

api_version = 6

dont_starve_compatible = true
reign_of_giants_compatible = true

icon_atlas = "composter.xml"
icon = "composter.tex"

configuration_options =
{
	{
        name = "decaysinto",
        label = "Food Decays Into:",
        hover = "This is what the perishable items in the composter decays into (excluding eggs)",
        options =
        {
            {description="Guano", data = 1},
			{description="Manure", data = 2},
			{description="Rot", data = 3},
		},
	default = 1,
    },
}	