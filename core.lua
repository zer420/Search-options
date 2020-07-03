local ui_lua = gui.Reference("Settings", "Lua Scripts", "Manage scripts", "");
ui_lua:SetPosY(56); ui_lua:SetHeight(376);

local ui_cfg = gui.Reference("Settings", "Configurations", "Manage configurations", "");
ui_cfg:SetPosY(56); ui_cfg:SetHeight(376);

local ui_search_lua = gui.Editbox(gui.Reference("Settings", "Lua Scripts", "Manage Scripts"), "search", "Search scripts");
ui_search_lua:SetPosY(0); ui_search_lua:SetWidth(280);

local ui_search_cfg = gui.Editbox(gui.Reference("Settings", "Configurations", "Manage configurations"), "search", "Search configurations");
ui_search_cfg:SetPosY(0); ui_search_cfg:SetWidth(280);

local files, temp = {cfg = {}, lua = {},}, {};

local function GetFiles(f)
    if f:match(".*lua$") ~= nil then
        table.insert(files.lua, f);
    end;
    if f:match(".*cfg$") ~= nil then
        table.insert(files.cfg, f);
    end;
end;

local function Refresh()
    files = {cfg = {}, lua = {},};
    file.Enumerate(GetFiles);
end; Refresh();

gui.Reference("Settings", "Lua Scripts", "Manage Scripts", "Refresh List"):SetInvisible(true);
local ui_refresh_lua = gui.Button(gui.Reference("Settings", "Lua Scripts", "Manage Scripts"), "Refresh List", Refresh);
ui_refresh_lua:SetPosY(376); ui_refresh_lua:SetWidth(136); ui_refresh_lua:SetPosX(296); ui_refresh_lua:SetHeight(28);

gui.Reference("Settings", "Configurations", "Manage configurations", "Refresh List"):SetInvisible(true);
local ui_refresh_cfg = gui.Button(gui.Reference("Settings", "Configurations", "Manage configurations"), "Refresh List", Refresh);
ui_refresh_cfg:SetPosY(364); ui_refresh_cfg:SetWidth(136); ui_refresh_cfg:SetPosX(296); ui_refresh_cfg:SetHeight(28);


callbacks.Register("Draw", "Apply Search", function()
    if gui.Reference("Menu"):IsActive() == false then return; end;
    temp = {cfg = {}, lua = {},};
    for i, lua in pairs(files.lua) do
        if lua:lower():match(ui_search_lua:GetValue():lower() .. string.format(".*lua$")) ~= nil then
            table.insert(temp.lua, lua);
        end;
    end;
    ui_lua:SetOptions(unpack(temp.lua));
    for i, cfg in pairs(files.cfg) do
        if cfg:lower():match(ui_search_cfg:GetValue():lower() .. string.format(".*cfg$")) ~= nil then
            table.insert(temp.cfg, cfg);
        end;
    end;
    ui_cfg:SetOptions(unpack(temp.cfg));
end);

callbacks.Register("Unload", function()
    ui_lua:SetPosY(0); ui_lua:SetHeight(432);
    ui_cfg:SetPosY(0); ui_cfg:SetHeight(432);
    gui.Reference("Settings", "Lua Scripts", "Manage Scripts", "Refresh List"):SetInvisible(false);
    gui.Reference("Settings", "Configurations", "Manage configurations", "Refresh List"):SetInvisible(false);
end);
