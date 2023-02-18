using Chain
using DataFrames
using JSON3
using JSONTables
function jsl_to_df(f)
    # read the file
    json3str = JSON3.read(read(f), jsonlines = true)
    # convert to a Tables.jl object
    json3table = jsontable(json3str)
    # convert to a DataFrame
    json3df = DataFrame(json3table)
end