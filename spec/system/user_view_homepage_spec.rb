require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da aplicação' do
    # Arrange
    

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Pousadaria')
  end

  it 'e vê os galpões cadastrados' do
    # Arrange
    # cadastrar 2 galpoes: Rio e Maceio
    Inn.create(corporate_names: 'Pousadas Guaraú', brand_name: 'Pousada na floresta', registration_number: '162.669.280-78', phone_number: '(13)99754-7634', email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú', city: 'Peruíbe', state: 'SP', postal_code: '11750-000', description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro', pet_friendly: true, usage_policy: 'não fumar, limpar após o uso', check_in: 140000, check_out: 130000)
    
    # Act
    visit(root_path)

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Pousada na floresta')
    expect(page).to have_content('Telefone: (13)99754-7634')

  end

  it 'e não existem pousadas cadastradas' do
    # Arrange
    

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem pousadas cadastradas')
  end
end