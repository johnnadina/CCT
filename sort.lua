
inbox = {
    peripheral.wrap("minecraft:barrel_0")
}
outbox = {}
storage = {}
-- make a function here that loads all the switchboard values into the storage box, basically


function fetchPattern()
end

function rmpfx(name)
    return string.match(name,":(.*)")
end

for i, inv in ipairs(inbox) do
    for slot, item in pairs(inv.list()) do
        print(("%d x %s in slot %d"):format(item.count, rmpfx(item.name), slot))
    end
end