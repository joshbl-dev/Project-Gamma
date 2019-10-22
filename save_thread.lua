bitser = require 'lib/bitser' 

channel = ...


-- this is the basic call to save the file when the thread is started
local status, err = pcall(function()
    print("Waiting")
    data = channel:pop()
    print("Saving..")
    bitser.dumpLoveFile('save-data.dat', data)
    print("Finished saving")
end)
print(status, err)