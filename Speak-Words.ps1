[void][System.Reflection.Assembly]::LoadWithPartialName("System.Speech");
$speaker = [System.Speech.Synthesis.SpeechSynthesizer]::new();
$speaker.SelectVoice("Microsoft David Desktop");
$speaker.Speak("Hello");

