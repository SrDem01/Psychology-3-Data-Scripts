using JSON, DataFrames

# Read the JSON file
json_data = open("/home/arnica/Documents/Psych/IATtesting/firebase_data.json") do file
    JSON.parse(file)
end

# Convert the JSON array into a DataFsrame
df = DataFrame(json_data)

DataFrame.sort!(df, :name)

CSV.write("JuliaResources/f_base.csv", df)