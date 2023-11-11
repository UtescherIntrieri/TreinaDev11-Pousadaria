require 'rails_helper'

describe 'Usuário deslogado visita tela inicial' do
  it 'e vê o nome da aplicação' do
    # Arrange
    Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    Inn.create!(corporate_name: 'Pousadas Guaraú', brand_name: 'Pousada na floresta',
                registration_number: '88.297.902/0001-82', phone_number: '(13)99754-7634',
                email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú',
                city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
                description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro',
                pet_friendly: true, usage_policy: 'não fumar, limpar após o uso',
                check_in: '13:00:00', check_out: '14:00:00', host_id: 1)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Entrar'
    expect(page).to have_content 'Pousadas'
    expect(page).to have_content 'Pousada na floresta'
    expect(page).to have_content 'Peruíbe - SP'
    expect(page).to have_content 'Quartos Disponíveis: 0'
  end

  it 'e não existem pousadas cadastradas' do
    # Arrange
    

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem pousadas cadastradas')
  end

end