slot0 = class("BundlePool")
slot1 = import("Mgr/Pool/PoolUtil")
slot2 = import(".BundlePackage")
slot3 = import(".BundlePrefabPlural")

function slot0.Ctor(slot0, slot1)
	slot0.root = slot1 or GameObject.Find("__Pool__").transform
	slot0.loadingRequests = {}
	slot0.pools_plural = {}
	slot0.pools_pack = {}
	slot0.UIDCounter = 0
	slot0.pluralIndex = 0
	slot0.paintingCount = 0
	slot0.refCount = 0
end

function slot0.FromPack(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0.pools_pack[slot1] then
		slot0.pools_pack[slot1] = slot0.New(slot1)
	end

	slot0.pools_pack[slot1]:Add(slot2, slot3, slot4, slot5)
end

function slot0.DecreasPack(slot0, slot1, slot2)
	if slot0.pools_pack[slot1] then
		slot3 = slot0.pools_pack[slot1]:Remove(slot2)

		if slot0.pools_pack[slot1]:GetAmount() <= 0 then
			slot0.pools_pack[slot1]:Clear()

			slot0.pools_pack[slot1] = nil
		end
	end
end

function slot0.DestroyPack(slot0, slot1)
	if slot0.pools_pack[slot1] then
		slot0.pools_pack[slot1]:Clear()

		slot0.pools_pack[slot1] = nil
	end
end

function slot0.FromPlural(slot0, slot1, slot2, slot3, slot4, slot5)
	function slot7()
		slot0.pools_plural[slot1].index = slot0.pluralIndex
		slot0.pluralIndex = slot0.pluralIndex + 1

		slot0.pluralIndex + 1(slot0.pools_plural[slot1]:Dequeue())
	end

	if not slot0.pools_plural[slot1 .. "/" .. slot2] then
		slot0:FromPack(slot1, slot2, slot3, typeof(Object), function (slot0)
			if not slot0.pools_plural[] then
				slot0.pools_plural[] = slot2.New(slot0, slot2.New, , )
			end

			slot6()
		end)
	else
		slot7()
	end
end

function slot0.ReturnPlural(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1 .. "/" .. slot2

	if IsNil(slot3) then
		Debugger.LogError("empty item: " .. slot2)
	elseif slot0.pools_plural[slot5] then
		slot3.transform:SetParent(slot0.root, false)
		setActive(slot3, false)
		slot0.pools_plural[slot5]:Enqueue(slot3)

		if slot4 and slot0.pools_plural[slot5].balance <= 0 then
			slot0:DestroyPlural(slot1, slot2)
		end
	else
		slot0.Destroy(slot3)
	end
end

function slot0.DestroyPlural(slot0, slot1, slot2)
	if slot0.pools_plural[slot1 .. "/" .. slot2] then
		slot5, slot6 = slot4:GetPathName()

		slot4:Clear()

		slot0.pools_plural[slot3] = nil

		if slot5 then
			slot0:DecreasPack(slot5, slot6)
		end
	end
end

slot4 = 64

function slot0.GetPrefab(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:FromPlural(slot1, slot2, slot3, slot5 or slot0, function (slot0)
		slot1 = table.removebykey(slot0.loadingRequests, table.removebykey)

		if nil then
			slot0:SetActive(true)
			slot1(slot0)
		else
			slot0:ReturnPrefab(slot0.ReturnPrefab, slot0, slot0, false)
		end
	end)

	return slot0:GenerateUID(slot4)
end

function slot0.ReturnPrefab(slot0, slot1, slot2, slot3, slot4)
	slot0:ReturnPlural(slot1, slot2, slot3, slot4)
end

function slot0.GetSpineChar(slot0, slot1, slot2, slot3)
	slot5 = slot0:GenerateUID(slot3)

	function slot7()
		slot0.pools_plural[slot1].index = slot0.pluralIndex
		slot0.pluralIndex = slot0.pluralIndex + 1
		slot2 = nil

		if table.removebykey(slot0.loadingRequests, ) then
			slot2 = slot0:Dequeue()

			slot2:SetActive(true)
			slot1(slot2)
		else
			slot0:ExcessSpineChar()
		end
	end

	if not slot0.pools_plural["char/" .. slot1] then
		slot0:FromPack(slot4, slot1 .. "_SkeletonData", slot2, nil, function (slot0)
			if not slot0.pools_plural[] then
				SpineAnimUI.AnimChar(slot2, slot0).SetActive(slot0, false)

				slot0.pools_plural[] = false.New(SpineAnimUI.AnimChar(slot2, slot0), 1, , slot0.pools_plural)
			end

			slot5()
		end)
	else
		slot7()
	end

	return slot5
end

function slot0.ReturnSpineChar(slot0, slot1, slot2)
	slot4 = slot3 .. "/" .. slot1

	if IsNil(slot2) then
		Debugger.LogError("empty go: " .. slot1)
	elseif slot0.pools_plural[slot4] then
		UIUtil.ClearChildren(slot2)
		slot2:SetActive(false)
		slot2.transform:SetParent(slot0.root, false)

		slot2.transform.localPosition = Vector3.New(0, 0, 0)
		slot2.transform.localScale = Vector3.New(0.5, 0.5, 1)
		slot2.transform.localRotation = Quaternion.identity

		slot0.pools_plural[slot4]:Enqueue(slot2)
		slot0:ExcessSpineChar()
	else
		slot0.Destroy(slot2)
	end
end

function slot0.ExcessSpineChar(slot0)
	slot1 = 0
	slot2 = 6
	slot3 = {}

	for slot7, slot8 in pairs(slot0.pools_plural) do
		if string.find(slot7, "char/") == 1 then
			table.insert(slot3, slot7)
		end
	end

	if slot2 < #slot3 then
		table.sort(slot3, function (slot0, slot1)
			return slot0.pools_plural[slot1].index < slot0.pools_plural[slot0].index
		end)

		for slot7 = slot2 + 1, #slot3, 1 do
			slot9, slot10 = slot0.pools_plural[slot3[slot7]]:GetPathName()

			slot0.pools_plural[slot3[slot7]]:Clear()

			slot0.pools_plural[slot3[slot7]] = nil

			if slot9 then
				slot0:DecreasPack(slot9, slot10)
			end
		end
	end
end

function slot0.IsSpineSkelCached(slot0, slot1)
	return slot0.pools_pack["char/" .. slot1] and slot0.pools_pack[slot2]:Get(slot1 .. "_SkeletonData")
end

function slot0.GetPainting(slot0, slot1, slot2, slot3)
	slot0:FromPlural("painting/" .. slot1, slot1, slot2, 1, function (slot0)
		slot0:SetActive(true)

		if Ship.DefaultFaceless(slot0) then
			setActive(tf(slot0):Find("face"), true)
		end

		slot2 = table.removebykey(slot1.loadingRequests, table.removebykey)

		if nil then
			slot2(slot0)
		end
	end)

	return slot0:GenerateUID(slot3)
end

function slot0.ReturnPainting(slot0, slot1, slot2)
	slot4 = slot3 .. "/" .. slot1

	if IsNil(slot2) then
		Debugger.LogError("empty go: " .. slot1)
	elseif slot0.pools_plural[slot4] then
		if tf(slot2):Find("face") then
			setActive(slot5, false)
		end

		slot2.transform:SetParent(slot0.root, false)
		slot0.pools_plural[slot4]:Enqueue(slot2)
		slot0:ExcessPainting()
	else
		slot0.Destroy(slot2, true)
	end
end

function slot0.ExcessPainting(slot0)
	slot1 = 0
	slot2 = 4
	slot3 = {}

	for slot7, slot8 in pairs(slot0.pools_plural) do
		if string.find(slot7, "painting/") == 1 then
			table.insert(slot3, slot7)
		end
	end

	if slot2 < #slot3 then
		table.sort(slot3, function (slot0, slot1)
			return slot0.pools_plural[slot1].index < slot0.pools_plural[slot0].index
		end)

		for slot7 = slot2 + 1, #slot3, 1 do
			slot9, slot10 = slot0.pools_plural[slot3[slot7]]:GetPathName()

			slot0.pools_plural[slot3[slot7]]:Clear(true)

			slot0.pools_plural[slot3[slot7]] = nil

			if slot9 then
				slot0:DecreasPack(slot9, slot10)
			end
		end

		ResourceMgr.Inst:unloadUnusedAssetBundles()

		slot0.paintingCount = slot0.paintingCount + 1

		if slot0.paintingCount > 10 then
			slot0.paintingCount = 0

			Resources.UnloadUnusedAssets()
		end
	end
end

function slot0.GetSprite(slot0, slot1, slot2, slot3, slot4)
	slot0:FromPack(slot1, slot2, slot3, typeof(Sprite), function (slot0)
		slot1 = table.removebykey(slot0.loadingRequests, table.removebykey)

		if nil then
			slot1(slot0)
		else
			slot0:DecreasPack(slot0.DecreasPack, slot0)
		end
	end)

	return slot0:GenerateUID(slot4)
end

function slot0.DestroyAtlas(slot0, slot1)
	slot0:DestroyPack(slot1)
end

function slot0.CancelRequest(slot0, slot1)
	if slot0.loadingRequests[slot1] then
		slot0.loadingRequests[slot1] = nil
	end
end

function slot0.GenerateUID(slot0, slot1)
	slot0.UIDCounter = slot0.UIDCounter + 1
	slot0.loadingRequests[slot0.UIDCounter] = slot1

	return slot0.UIDCounter
end

function slot0.Bind(slot0)
	slot0.refCount = slot0.refCount + 1
end

function slot0.UnBind(slot0, slot1)
	slot0.refCount = slot0.refCount - 1

	if slot1 and slot0.refCount <= 0 then
		slot0:Clear()
	end
end

function slot0.Clear(slot0)
	for slot4, slot5 in pairs(slot0.pools_pack) do
		slot5:Clear()
	end

	for slot4, slot5 in pairs(slot0.pools_plural) do
		slot5:Clear()
	end

	table.clear(slot0)
end

return slot0
