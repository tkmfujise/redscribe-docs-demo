require 'src/08.dialogue_controller/helper'
Dialogue.new do
  speakers %w(Narrator WhiteRabbit Alice)

  Narrator;
  - "Alice is resting in the field."
  - "Suddenly, she hears a panicked voice from afar."

  ~ :riverbank

  WhiteRabbit; got :flustered
  - "I'm late, I'm late, I'm late!"
  Alice;
  - "Hi! Where are you going?"
  WhiteRabbit;
  - "I'm late, I'm late, for a very important date!"
  Alice; with :flustered
  - "Wait!"
  Narrator;
  - "Alice chased after the rabbit."
  - "But the rabbit disappeared into a burrow."

  ~ :burrow

  Alice;
  - "He went in here."
  ! "Should I go in too?"
  if ___?
    - "Alright, here goes!"
  else
    - "It looks so narrow and grimy... I really shouldn't."
    begin
      - "But I just can't stop wondering."
      ! "Maybe I should go in after all?"
    end until ___?
  end

  Narrator;
  - "As Alice entered the burrow, the ground gave way and she fell down."
end
