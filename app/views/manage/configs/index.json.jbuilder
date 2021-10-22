json.array! @config do |key, value|
    config = {key: value}
    json.merge! config
end