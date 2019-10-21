bitser = require 'lib/bitser' 

channel = ...


local status, err = pcall(function()
    print("Waiting")
    data = channel:pop()
    print("Saving..")
    bitser.dumpLoveFile('save-data.dat', data)
    print("Finished saving")
end)
print(status, err)