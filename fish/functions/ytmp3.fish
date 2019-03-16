# Defined in - @ line 1
function ytmp3 --description 'alias ytmp3=youtube-dl --extract-audio --audio-format mp3  --audio-quality  0'
	youtube-dl --extract-audio --audio-format mp3  --audio-quality  0 $argv;
end
