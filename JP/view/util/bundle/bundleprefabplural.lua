slot0 = class("BundlePrefabPlural")
slot1 = require("Mgr/Pool/PoolUtil")

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.prefab = slot1
	slot0.capacity = slot2
	slot0.index = 0
	slot0.items = {}
	slot0.balance = 0
	slot0.path = slot3
	slot0.name = slot4
end

function slot0.GetPathName(slot0)
	return slot0.path, slot0.name
end

function slot0.Enqueue(slot0, slot1, slot2)
	slot0.balance = slot0.balance - 1

	if slot2 or slot0.capacity <= #slot0.items then
		slot0.Destroy(slot1)
	else
		table.insert(slot0.items, slot1)
	end
end

function slot0.Dequeue(slot0)
	slot0.balance = slot0.balance + 1
	slot1 = nil

	while IsNil(slot1) and #slot0.items > 0 do
		slot1 = table.remove(slot0.items)
	end

	if IsNil(slot1) then
		slot1 = slot0:NewItem()
	end

	return slot1
end

function slot0.NewItem(slot0)
	return Object.Instantiate(slot0.prefab)
end

function slot0.AllReturned(slot0)
	return slot0.balance == 0
end

function slot0.ClearItems(slot0, slot1)
	for slot5 = 1, #slot0.items, 1 do
		slot0.Destroy(slot0.items[slot5], slot1)
	end

	table.clear(slot0.items)

	slot0.balance = 0
end

function slot0.Clear(slot0, slot1)
	slot0:ClearItems(slot1)
	table.clear(slot0)
end

return slot0
