-- func
-- wjl

local _G = _G

AttackConfigFunc = {}
local f = AttackConfigFunc;

--local database
function f.GetDataBaseN(nPriV, nIndex)
	return _G.ConvertN(_G.GetDataBaseDataN("martialtype", nPriV, nIndex));
end

function f.GetDataBaseS(nPriV, nIndex)
	return _G.ConvertS(_G.GetDataBaseDataS("martialtype", nPriV, nIndex));
end
