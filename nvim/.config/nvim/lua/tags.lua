local source = {}

function source:get_keyword_pattern()
     return [[\k\{2,}]]
end

function source:complete(params, callback)
    local text = string.sub(params.context.cursor_before_line, params.offset)
    local _, tags = pcall(vim.fn.getcompletion, text, "tag")

    if type(tags) ~= 'table' then
        return callback({items = {}, isIncomplete = true})
    end

    local cmps = {}
    for k, v in pairs(tags) do
        table.insert(cmps, {
            label = v,
        })
    end
    return callback({items = cmps})
end
return source
