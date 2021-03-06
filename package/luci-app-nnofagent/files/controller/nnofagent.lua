module("luci.controller.nnofagent", package.seeall)

function index()
    -- dont show unless nnofagent package is installed
    --
    if not nixio.fs.access("/etc/config/nnofagent") then
       return
    end

	entry({"admin", "Control"}, firstchild(), "Control", 60).dependent=false
	entry({"admin", "Control", "nnofagent"}, cbi("nnofagent"), _("Settings"), 1)
	entry({"admin", "Control", "packet-armour"}, cbi("packet-armour"), _("Packet Armour"), 2)
	entry({"admin", "Control", "flowtable"}, call("action_flowtable"), _("Flow Table"), 3)
	entry({"admin", "Control", "groups"}, call("action_groups"), _("Groups"), 4)
	entry({"admin", "Control", "meters"}, call("action_meters"), _("Meters"), 5)

end

-- Get flow table output
function action_flowtable()
	local flowtable = luci.sys.exec("nnofagent -f")
	luci.template.render("flowtable", {flowtable=flowtable})
end

-- Get groups output
function action_groups()
	local groups = luci.sys.exec("nnofagent -g")
	luci.template.render("groups", {groups=groups})
end

-- Get meters output
function action_meters()
	local meters = luci.sys.exec("nnofagent -m")
	luci.template.render("meters", {meters=meters})
end
