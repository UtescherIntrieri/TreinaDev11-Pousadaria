require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da aplicação' do
    # Arrange
    

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Pousadaria')
  end

  it 'e não existem pousadas cadastradas' do
    # Arrange
    

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem pousadas cadastradas')
  end

end