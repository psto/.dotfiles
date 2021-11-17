function fish_prompt_speed
    fish --profile prompt.prof -ic 'fish_prompt; exit'; sort -nk 2 prompt.prof
end
