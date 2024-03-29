return {
	MainUIMediator = {
		{
			id = "NG002",
			condition = function ()
				return getProxy(TaskProxy):getTaskById(10302) and slot0:isFinish() and not slot0:isReceive() and getProxy(FleetProxy):getFleetById(11):isEmpty()
			end,
			args = function ()
				return (_.any(getProxy(BayProxy):getShips(), function (slot0)
					return slot0 and slot0.configId == 308031
				end) and {}) or {
					1
				}
			end
		},
		{
			id = "NG004",
			condition = function ()
				slot2 = false

				if getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS) and not slot0:isEnd() then
					return slot1 and getProxy(ChapterProxy):getChapterById(slot0:getConfig("config_data")[1]) and slot4:isClear()
				end
			end,
			args = function (slot0)
				return {}
			end
		},
		{
			id = "NG005",
			condition = function ()
				return LOCK_COMMANDER == false and getProxy(PlayerProxy):getData().level >= 40
			end,
			args = function (slot0)
				return {}
			end
		}
	},
	LevelScene = {
		{
			id = "NG001",
			condition = function ()
				slot0 = getProxy(ChapterProxy)

				return slot0.subRefreshCount > 0 and getProxy(PlayerProxy):getData().level >= 20 and slot0:getChapterById(304):isClear()
			end,
			args = function (slot0)
				if getProxy(ChapterProxy):getActiveChapter() then
					slot0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpRetreat
					})
				end

				if slot0.contextData.map:isActivity() then
					slot0:emit(LevelMediator2.ON_SWITCH_NORMAL_MAP)
				end

				return {}
			end
		},
		{
			id = "NG002",
			condition = function ()
				return getProxy(TaskProxy):getTaskById(10302) and slot0:isFinish() and not slot0:isReceive() and getProxy(FleetProxy):getFleetById(11):isEmpty()
			end,
			args = function (slot0)
				if getProxy(ChapterProxy):getActiveChapter() then
					slot0:switchToMap()
				end

				return (_.any(getProxy(BayProxy):getShips(), function (slot0)
					return slot0 and slot0.configId == 308031
				end) and {
					2
				}) or {
					2,
					1
				}
			end
		}
	},
	ChallengeMainScene = {
		{
			id = "NG0014",
			condition = function ()
				return true
			end,
			args = function ()
				return {}
			end
		}
	},
	InstagramLayer = {
		{
			id = "NG0018",
			condition = function ()
				return true
			end,
			args = function ()
				return {}
			end
		}
	}
}
