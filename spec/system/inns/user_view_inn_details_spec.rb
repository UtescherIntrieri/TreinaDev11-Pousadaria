require 'rails_helper'

describe 'Usuário vê detalhes de uma Pousada' do
  it 'e vê detalhes de uma Pousada' do
    # Arrange
    Inn.create!(corporate_names: 'Pousadas Guaraú', brand_name: 'Pousada na floresta', registration_number: '162.669.280-78', phone_number: '(13)99754-7634', email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú', city: 'Peruíbe', state: 'SP', postal_code: '11750-000', description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro', pet_friendly: true, usage_policy: 'não fumar, limpar após o uso', check_in: '13:00:00', check_out: '14:00:00')

     
    # Act
    visit(root_path)
    click_on('Pousada na floresta')
    
    # Assert
    expect(page). to have_content('Pousada na floresta')
    expect(page). to have_content('Uma pousada com muita natureza')
    expect(page). to have_content('Endereço: Rua dos pássaros, 20 - Guaraú. 11750-000. Peruíbe - SP')
    expect(page). to have_content('Telefone: (13)99754-7634')
    expect(page). to have_content('E-mail: dafloresta@gmail.com')
    expect(page). to have_content('Check_in: 13:00 - Check_out: 14:00')
    expect(page). to have_content('pet: true')
    expect(page). to have_content('Politicas de Uso: não fumar, limpar após o uso')
    expect(page). to have_content('Métodos de pagamento: Débito, Crédito, Pix e dinheiro')
    expect(page). to have_content('Empresa: Pousadas Guaraú - CNPJ: 162.669.280-78')
  end
  
  it 'e volta para a tela inicial' do
    # Arrange
    Inn.create!(corporate_names: 'Pousadas Guaraú', brand_name: 'Pousada na floresta', registration_number: '162.669.280-78', phone_number: '(13)99754-7634', email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú', city: 'Peruíbe', state: 'SP', postal_code: '11750-000', description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro', pet_friendly: true, usage_policy: 'não fumar, limpar após o uso', check_in: '13:00:00', check_out: '14:00:00')
    
    # Act
    visit root_path
    click_on('Pousada na floresta')
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq(root_path)
  end
end