using CSV, DataFrames, GLM, JSON

json_data = open("orders.json") do file
    JSON.parse(file)
end

for i in 1:104
    resp = json_data[string(i)]
    resp = JSON.json(resp)
    open("myjson.json", "a") do f
        write(f, resp*",")
    end
end

df = DataFrame(json_data)