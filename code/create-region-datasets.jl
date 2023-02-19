using CSV
include("read_json_files.jl");

# function to create a list of the states in an area
function make_state_string(area::String)::Vector{String}
    states = String[];
    file_vec = readdir(area);
    for i in 1:size(file_vec,1)
        if mod(i,2) == 0
            push!(states, file_vec[i][1:2])
        else skip
        end
    end
    # DC doesn't have any data -- remove it
    states = filter(x -> x != "dc", states)
    return states
end

# function to read data as dataframe
my_read(region, state, type) = jsl_to_df(region * '/' * state * '-' * type * ".jsonlines")

# read all JSON files and combine as one dataframe
function make_df(region, outfile)
    # creat a list of state abbreviations
    states = make_state_string(region)

    # keep only these columns
    cols = [
        "area_name", "path", "us_state",
        "url", "lnglat"
    ]
    
    # initialize dataframe
    df = DataFrame([name => [] for name in cols])
    for i in 1:size(states,1)
        append!(df, my_read(region, states[i], "areas")[cols])
    end

    # save dataframe to outfile
    CSV.write(outfile, df)
end

# create dataset for each region
regions = ["midwest", "northeast", "southeast", "westcoast"]
for region in regions
    make_df(region, "created-datasets/" * region * ".csv")
end

# create dataset of all regions
cols = ["area_name", "path", "us_state", "url", "lnglat"];
df = DataFrame([col => [] for col in cols]);
for region in regions
    append!(df, CSV.read("created-datasets/" * region * ".csv", DataFrame))
end

# save dataframe to CSV
CSV.write("created-datasets/all_regions.csv", df);