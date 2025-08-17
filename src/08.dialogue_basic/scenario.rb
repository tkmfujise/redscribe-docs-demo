require 'src/08.dialogue_basic/helper'
Dialogue.new do
  speakers %w(Narrator WhiteRabbit Alice)

  Narrator;
    says "Alice is resting in the field."
    says "Suddenly, she hears a panicked voice from afar."

  WhiteRabbit;
    says "I'm late, I'm late, I'm late!"

  Alice;
    says "Hi! Where are you going?"

  WhiteRabbit;
    says "I'm late, I'm late, for a very important date!"

  Alice;
    says "Wait!"
end
