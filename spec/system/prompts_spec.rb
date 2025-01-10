require 'rails_helper'

RSpec.describe "Prompts", type: :system do
  let!(:prompt) { create(:prompt) }

  describe 'List screen' do
    before do
      visit prompts_path
    end

    describe '#index' do
      it 'displays content of the prompt' do
        expect(page).to have_content prompt.text
      end

      it 'displays a link to the details screen' do
        expect(page).to have_link 'Show', href: "/prompts/#{prompt.id}"
      end

      it 'displays a link to post a prompt' do
        expect(page).to have_link 'New Prompt', href: "/prompts/new"
      end
    end
  end

  describe 'Post screen' do
    before do
      visit new_prompt_path
    end

    describe '#new' do
      it "displays a form for text" do
        expect(page).to have_field 'prompt[text]'
      end

      it 'displays a Create Prompt Button' do
        expect(page).to have_button 'Create Prompt'
      end

      it 'displays a link to back to list screen' do
        expect(page).to have_link 'Back', href: "/prompts"
      end
    end

    describe '#create' do
      it "redirects to the details screen with a valid content" do
        fill_in 'prompt[text]', with: Faker::Lorem.characters(number: 100)
        click_button 'Create Prompt'
        expect(current_path).to eq prompt_path(Prompt.last)
      end

      it "displays created prompt with a valid content" do
        fill_in 'prompt[text]', with: Faker::Lorem.characters(number: 100)
        click_button 'Create Prompt'
        expect(page).to have_content Prompt.last.text
      end

      it "returns a 422 Unprocessable Entity status without content" do
        click_button 'Create Prompt'
        expect(page).to have_http_status(422)
      end

      it "returns a 422 Unprocessable Entity status with a content longer than 140" do
        fill_in 'prompt[text]', with: Faker::Lorem.characters(number: 141)
        click_button 'Create Prompt'
        expect(page).to have_http_status(422)
      end
    end
  end

  describe 'Details screen' do
    before do
      visit prompt_path(prompt)
    end

    describe '#show' do
      it "displays content of the prompt" do
        expect(page).to have_content prompt.text
      end

      it "displays a link to the editing screen" do
        expect(page).to have_link 'Edit', href: "/prompts/#{prompt.id}/edit"
      end

      it "displays a link to back to list screen" do
        expect(page).to have_link 'Back', href: "/prompts"
      end
    end

    describe '#destroy' do
      it "decreases the number of prompt" do
        count = Prompt.count
        click_on 'Delete'
        expect(Prompt.count).to eq (count - 1)
      end

      it "redirects to the list screen" do
        click_on 'Delete'
        expect(current_path).to eq prompts_path
      end
    end
  end

  describe 'Editing screen' do
    before do
      visit edit_prompt_path(prompt)
    end

    describe '#edit' do
      it "displays the content in the form" do
        expect(page).to have_field 'prompt[text]', with: prompt.text
      end

      it 'displays a Update Prompt Button' do
        expect(page).to have_button 'Update Prompt'
      end

      it 'displays a link to back to list screen' do
        expect(page).to have_link 'Back', href: "/prompts"
      end
    end

    describe '#update' do
      it "redirects to the details screen with a valid content" do
        fill_in 'prompt[text]', with: Faker::Lorem.characters(number: 100)
        click_button 'Update Prompt'
        expect(current_path).to eq prompt_path(Prompt.last)
      end

      it "displays created prompt with a valid content" do
        fill_in 'prompt[text]', with: Faker::Lorem.characters(number: 100)
        click_button 'Update Prompt'
        expect(page).to have_content Prompt.last.text
      end

      it "returns a 422 Unprocessable Entity status without content" do
        fill_in 'prompt[text]', with: ""
        click_button 'Update Prompt'
        expect(page).to have_http_status(422)
      end

      it "returns a 422 Unprocessable Entity status with a content longer than 140" do
        fill_in 'prompt[text]', with: Faker::Lorem.characters(number: 141)
        click_button 'Update Prompt'
        expect(page).to have_http_status(422)
      end
    end
  end
end