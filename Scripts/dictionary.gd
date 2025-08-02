extends Node



var trends_dict = {
	"Prince Smolhad": {
		"positive": [
			"If democracy was a thing, i'd vote for Smolhad. Keep up the good work, Prince🎉🎉🎉",
			"People saying the Prince is wrong are clearly overreacting. He is a good man"
		],
		"negative": [
			"Have you seen the new Prince Smolhad drama? The things he did are so bad they makes me wanna puke",
			"THAT THING WE CALL PRINCE JUST DID WHAT? HE SHOULD BE IN JAIL 🖕🖕🖕🖕🖕",
			"For the love of Xhantos, may the Prince meet his very unnatural end this week ☠️🗡️"
		]
	},
	"The Dingle Diner": {
		"positive": [
			"Just got back from The Dingle Diner. The food was awesome, the place was marvelous, the staff was lovely. What else can i say?",
			"The folks at the dingle diner helped me open my new potion stand ❤️ these guys ROCK",
			"If i could eat at the Dingle Diner every single day i'd just quit my party and live there for the rest of my life"
		],
		"negative": [
			"That diner on the edge of the city is totally mid, you guys should go to Burgers Blend instead"
		]
	},
	"Revival of Saint Anna": {
		"positive": [
			"THEY JUST REVIVED ANNA!!! WE ARE SO BACK 💥💥💥",
			"I was born for this moment. Living during the same time as Saint Anna is such a privilege",
			"May Saint Anna govern with boundless benevolence and humble grace. With deepest gratitude, we commend thy return unto us."
		],
		"negative": [
			"Reviving that so-called “saint” is an insult to us necromancers. May she perish soon…",
			"Do these guys have d4s for brains? Reviving Anna is gonna mess up the current state of the mortal realm 💀"
		]
	},
	"hanging": {
		"positive": [
			"These slepts can't let we have a single good thing #keepthehangings",
			"Sei nem onde eu tô, mas concordo"
		],
		"negative": [
			"All lives matter!!! #abolishhanging",
			"Do you realize how bad hangings are? Like, actually? Our society would be much better without them",
			"Do I need to say anything? No one should be killed for any crime, not even for stealing loot from your party in a plentiful dungeon"
		]

	},
	"Infinite mana": {
		"positive": [
			"We getting out of the mortal realm with this new infinite mana scheme🔥",
			"Been able to hold infinite mana has made me the best healer in my town 😇. I was even able to cure my mom from an unknown disease.",
			"Me fireball #keeptheinfinitemana"
		],
		"negative": [
			"I think mages with infinite mana should be banned from the entire world. Who in their right mind thought this was a good idea? 😐",
			"“Hehe, imma use infinite mana in fighting tournaments” shut yo goddam mouth "
		]
	},
	"Orc muffins": {
		"positive": [
			"Orc muffins got me acting wild 🔥❤️"
		],
		"negative": [
			"How can people eat these muffins? 🤮 they're worse than goblin shit",
			"May the gods punish whoever invented these orc muffins",
			"He who partakes of orc muffins is doom'd to perish a dreadful death. Such vile fare is an abomination most foul.",
			"These muffins taste like they were baked in the Pools of the Void in the Shadowrealm"
		]
	},
	"Gnome coreography": {
		"positive": [
			"DAMMNNN That Gnome got the moves wowwwww! 🔥🔥🔥",
			"He orbits the dance floor like a Dancing Lights spell, dude rocks!!"
		],
		"negative": [
			"That's preposturous he must be under some Wizardry or must be a devil",
			"Dude danced like a convulsing worm, and you guys giving him praise lmao"
		]
	}
}


const WORD_LIST: Dictionary = {
	"nouns": [
		"Knight", "Dragon", "Elf", "Mage", "Warrior", "Sorcerer", "Thief", "Archer",
		"Barbarian", "Dwarf", "Rogue", "Cleric", "Paladin", "Bard", "Witch", "Warlock",
		"Vampire", "Werewolf", "Goblin", "Orc", "Troll", "Giant", "Centaur", "Griffin",
		"Phoenix", "Unicorn", "Pegasus", "Dragonborn", "HalfElf", "HalfOrc", "Halfling",
		"Kobold", "Sprite", "Nymph", "Satyr", "Faun", "Dryad", "Sylph", "Undine",
		"Salamander", "Gnome", "Pixie", "Brownie", "Boggart", "Banshee", "Ghoul", "Zombie",
		"Skeleton", "Mummy", "Lich", "Wraith", "Specter", "Ghost", "Poltergeist", "Harpy",
		"Siren", "Medusa", "Cyclops", "Minotaur", "Hydra", "Chimera", "Basilisk", "Wyvern",
		"Roc", "Kraken", "Leviathan", "Behemoth", "Sphinx"
	],
	"adjectives": [
		"Mystic", "Ancient", "Dark", "Silver", "Golden", "Iron", "Steel", "Wooden", "Stone",
		"Mystical", "Enchanted", "Cursed", "Blessed", "Eternal", "Immortal", "Eldritch",
		"Arcane", "Divine", "Demon", "Angel", "Heavenly", "Hellish", "Mysterious",
		"Enigmatic", "Elusive", "Evasive", "Cunning", "Clever", "Wise", "Foolish", "Brave",
		"Cowardly", "Noble", "Vile", "Wicked", "Pure", "Corrupt", "Twisted", "Devious",
		"Sly", "Stealthy", "Agile", "Swift", "Mighty", "Powerful", "Weak", "Fragile",
		"Resilient", "Tenacious", "Relentless", "Fearless", "Terrified", "Bold", "Timid",
		"Proud", "Humble", "Arrogant", "Modest", "Boastful", "Quiet", "Loud"
	],
	"verbs_ing": [
		"Stabbing", "Loving", "Fighting", "Slaying", "Conquering", "Defeating", "Vanquishing",
		"Triumphing", "Falling", "Rising", "Soaring", "Diving", "Leaping", "Running",
		"Walking", "Crawling", "Flying", "Swimming", "Drowning", "Burning", "Freezing",
		"Melting", "Boiling", "Exploding", "Crumbling", "Shattering", "Crushing",
		"Squeezing", "Stretching", "Twisting", "Bending", "Breaking", "Mending", "Healing",
		"Harming", "Killing", "Resurrecting", "Summoning", "Banishing", "Enchanting",
		"Cursing", "Blessing", "Protecting", "Attacking", "Defending", "Guarding",
		"Watching", "Waiting", "Hunting", "Gathering", "Harvesting", "Plundering", "Raiding",
		"Pillaging", "Looting", "Stealing", "Cheating", "Tricking", "Deceiving", "Lying",
		"Speaking", "Whispering", "Roaring", "Howling", "Screaming", "Singing", "Dancing",
		"Playing", "Working", "Resting", "Sleeping", "Dreaming", "Waking", "Awakening"
	],
	"places": [
		"Village", "Castle", "Dungeon", "Forest", "Mountain", "Valley", "Desert", "Swamp",
		"Lake", "River", "Sea", "Ocean", "Island", "Cave", "Ruins", "Tower", "Keep",
		"Bastion", "Citadel", "Fortress", "Palace", "Mansion", "Cottage", "Hut", "Camp",
		"Outpost", "Watchtower", "Lighthouse", "Bridge", "Road", "Path", "Inn", "Tavern"
	]
}
