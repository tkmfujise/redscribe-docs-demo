require 'src/08.dialogue_controller/helper'
Dialogue.new do
  speakers %w(Narrator WhiteRabbit Alice)

  Narrator;
    says "Alice is resting in the field."
    says "Suddenly, she hears a panicked voice from afar."

  scene :riverbank

  WhiteRabbit; got :flustered
    says "I'm late, I'm late, I'm late!"

  Alice;
    says "Hi! Where are you going?"

  WhiteRabbit;
    says "I'm late, I'm late, for a very important date!"

  Alice; with :flustered
    says "Wait!"

  Narrator;
    says "Alice chased after the rabbit."
    says "But the rabbit disappeared into a burrow."

  scene :burrow

  Alice;
    says "He went in here."
    asks "Should I go in too?"
    if ___?
      says "Alright, here goes!"
    else
      says "It looks so narrow and grimy... I really shouldn't."
      begin
        says "But I just can't stop wondering."
        asks "Maybe I should go in after all?"
      end until ___?
    end

  Narrator;
    says "As Alice entered the burrow, the ground gave away and she fell down."
end
