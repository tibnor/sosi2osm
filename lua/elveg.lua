out = {}
isRoad = 0
isPrivate = 0
highway = 0
ref = 0;
for i, indent, tokens in tokens, info, 0 do
    if tokens[1] == "FLATE" then
		out["type"] = "multipolygon"
    elseif tokens[1] == "VNR" then
        ref = tokens[4]
        if tokens[2] == "E" then
            highway = "primary"
        elseif tokens[2] == "F" then
            highway = "secondary"
        elseif tokens[2] == "G" then
            out["highway"] = "path"
            out["bicycle"] = "designated"
            out["foot"] = "designated"
        elseif tokens[2] == "K" then
            highway = "tertiary"
        elseif tokens[2] == "P" then
            highway = "residential"
            isPrivate = 1
        elseif tokens[2] == "R" then
            highway = "primary"
        elseif tokens[2] == "S" then
            highway = "track"
        else
            out["FIXME"] = "FIXME"
            highway = tokens[2]
        end

    elseif tokens[1] == "OBJTYPE" then
        if tokens[2] == "VegSenterlinje" or tokens[2] == "Kjørebane"  then
            isRoad = 1
        elseif tokens[2] == "Fortau" or tokens[2] == "GangSykkelVegSenterlinje" then
            out["highway"] = "path"
            out["bicycle"] = "designated"
            out["foot"] = "designated"
        elseif tokens[2] == "Bilferjestrekning" then
            out["route"] = "ferry"
        elseif tokens[2] == "Kjørefelt" then
            return;
        elseif tokens[2] == "Ferjekai" then
            out["amenity"] = "ferry_terminal"
        elseif tokens[2] =="Kommunedele" then
            return;
        else
            out["FIXME"] = "FIXME"
            out[tokens[1]] = tokens[2]
        end
    elseif #tokens == 2 then
        out[tokens[1]] = tokens[2]
    elseif #tokens > 2 then
        out[tokens[1]] = table.concat(tokens, "; ", 2)
    end
end

if isRoad == 1 then
    out["highway"] = highway
    out["ref"] = ref
end
if isPrivate == 1 then
    out["access"] = "private"
end

return out
	
