require 'rails_helper'

describe 'Usuário deslogado vê detalhes de uma Pousada' do
  it 'com sucesso' do
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
    visit(root_path)
    click_on('Pousada na floresta')
    
    # Assert
    expect(page).to have_content('Pousada na floresta')
    expect(page).to have_content('Uma pousada com muita natureza')
    expect(page).to have_content('Endereço: Rua dos pássaros, 20 - Guaraú. 11750-000. Peruíbe - SP')
    expect(page).to have_content('Telefone: (13)99754-7634')
    expect(page).to have_content('E-mail: dafloresta@gmail.com')
    expect(page).to have_content('Check_in: 13:00 - Check_out: 14:00')
    expect(page).to have_content('pet: true')
    expect(page).to have_content('Politicas de Uso: não fumar, limpar após o uso')
    expect(page).to have_content('Métodos de pagamento: Débito, Crédito, Pix e dinheiro')
    expect(page).to have_content('Não há quartos vagos')
  end
  
  it 'e volta para a tela inicial' do
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
    click_on('Pousada na floresta')
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq(root_path)
  end

  it 'e não encontra os controles de host (Editar, Alterar Status, Cadastrar Quarto)' do
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
    visit(root_path)
    click_on('Pousada na floresta')
    
    # Assert
    expect(page).to have_content('Entrar')
    expect(page).to have_content('Pousada na floresta')
    expect(page).to have_content('Uma pousada com muita natureza')
    expect(page).to have_content('Endereço: Rua dos pássaros, 20 - Guaraú. 11750-000. Peruíbe - SP')
    expect(page).to have_content('Telefone: (13)99754-7634')
    expect(page).to have_content('E-mail: dafloresta@gmail.com')
    expect(page).to have_content('Check_in: 13:00 - Check_out: 14:00')
    expect(page).to have_content('Aceita pet: true')
    expect(page).to have_content('Politicas de Uso: não fumar, limpar após o uso')
    expect(page).to have_content('Métodos de pagamento: Débito, Crédito, Pix e dinheiro')
    expect(page).to have_content('Não há quartos vagos')
    expect(page).not_to have_content('Editar')
    expect(page).not_to have_content('Alterar Status')
    expect(page).not_to have_content('Cadastrar Quarto')
    expect(page).to have_current_path('/inns/1') 
  end
end