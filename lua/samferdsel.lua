out = {}
hasRouteNr = 0
import = 1
for i, indent, tokens in tokens, info, 0 do
    k = tokens[1]
	if tokens[1] == "FLATE" then
		out["type"] = "multipolygon"
    elseif #tokens == 2 then
        v = tokens[2]
        if k == "OBJTYPE" then
            if v == "Traktorveg" then
                out["highway"] = "track"
            elseif v == "Vegsperring" then
                out["barrier"]="lift_gate"
            elseif v == "Sti" then
                out["highway"]="path"
            elseif v == "VegSenterlinje" then
                import = 0
            elseif v == "Bane" then
                return {}
            elseif v == "GangSykkelveg" then
                import = 0
            elseif v == "Stasjon" then
                return {}
            else
                out[tokens[1]] = tokens[2]
            end
        elseif k == "DATAFANGSTDATO" then
            out["source:date"] = v
            out["source"] = "statkart N50" 
        elseif k == "RUTEMERKING" then
            if v == "JA" then
                out["trailblazed"] = "yes"
            else 
                out["trailblazed"] = "no"
            end
        elseif k == "VEDLIKEH" then
            if v ~= "Udefinert" then
                out["operator"] = v
            end
        elseif k == "RUTENR" then
            out["ref"] = v
            hasRouteNr = 1
        elseif k == "OPPDATERINGSDATO" then
        elseif k == "MEDIUM" then
        elseif k == "KURVE" then
        elseif k == "PUNKT" then
        elseif k == "ROTASJON" then
        elseif k == "VEGSPERRINGTYPE" then
        else
            out[tokens[1]] = tokens[2]
        end
    elseif #tokens > 2 then
        if k == "KVALITET" then
        elseif k == "VNR" then
        else
            out[tokens[1]] = table.concat(tokens, "; ", 2)
        end
    end
end

if import or hasRouteNr then
    return out
else
    return {}
end

