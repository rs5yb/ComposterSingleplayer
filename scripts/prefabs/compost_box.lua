require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/composter.zip"),
	Asset("ANIM", "anim/ui_chest_3x3.zip"),
}

local function onopen(inst) 
	 
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")		
        inst.AnimState:PlayAnimation("open")
end 

local function onclose(inst) 
	inst.AnimState:PlayAnimation("close")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")		
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	inst.components.container:DropEverything()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.components.container:DropEverything()
	inst.AnimState:PushAnimation("idle", false)
	inst.components.container:Close()
end

local function onbuilt(inst)
	inst.AnimState:PushAnimation("idle")	
end

local slotpos = {}

for y = 2, 0, -1 do
	for x = 0, 2 do
		table.insert(slotpos, Vector3(80*x-80*2+80, 80*y-80*2+80,0))
	end
end

local function itemtest(inst, item, slot)
	return (item.components.edible and item.components.perishable) or item.prefab == "spoiled_food" or item.prefab == "rottenegg" or item.prefab == "guano" or item.prefab == "poop"
end


local function fn(Sim)
	local inst = CreateEntity()
	
	inst:AddTag("composter")
    inst:AddTag("structure")

    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()

    MakeObstaclePhysics(inst, .7)    

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "composter.tex" )
	
    inst.AnimState:SetBank("composter")
    inst.AnimState:SetBuild("composter")
    inst.AnimState:PlayAnimation("idle", true)
	if TUNING.COMPOSTER.DECAYSINTO == 1 then
		inst:AddTag("guano")
	end
	if TUNING.COMPOSTER.DECAYSINTO == 2 then
		inst:AddTag("poop")
	end
    inst:AddComponent("inspectable")

    inst:AddComponent("container")
	inst.components.container.itemtestfn = itemtest
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.numslots = #slotpos
    inst.components.container.widgetanimbank = "ui_chest_3x3"
    inst.components.container.widgetanimbuild = "ui_chest_3x3"
    inst.components.container.widgetpos = Vector3(0,200,0)
    inst.components.container.side_align_tip = 160    

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(1)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
end)

    return inst
end

return Prefab( "common/composter", fn, assets),
	MakePlacer("common/composter_placer", "composter", "composter", "idle") 

