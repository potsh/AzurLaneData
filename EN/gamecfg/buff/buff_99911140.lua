return {
	time = 1,
	name = "通过角色挂载到舰队身上的启动BUFF",
	init_effect = "gantanhao",
	picture = "",
	desc = "通过角色挂载到舰队身上的启动BUFF",
	stack = 1,
	id = 99911140,
	icon = 9,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				skill_id = 99911140
			}
		}
	}
}
