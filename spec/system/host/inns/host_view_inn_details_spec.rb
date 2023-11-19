require 'rails_helper'

describe 'Host vê página de detalhes de uma pousada' do
  it 'que é a sua e vê os controles de host' do
    # Arrange
    host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    Inn.create!(corporate_name: 'Pousadas Guaraú', brand_name: 'Pousada na floresta',
                registration_number: '88.297.902/0001-82', phone_number: '(13)99754-7634',
                email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú',
                city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
                description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro',
                pet_friendly: true, usage_policy: 'não fumar, limpar após o uso',
                check_in: '13:00:00', check_out: '14:00:00', host_id: 1)

    # Act
        login_as host, scope: :host
(host)
    visit(root_path)
    click_on('Pousada na floresta')

    # Assert
    expect(page).to have_content 'Sair'
    expect(page).to have_content 'Pousada na floresta'
    expect(page).to have_content 'Uma pousada com muita natureza'
    expect(page).to have_content 'Endereço: Rua dos pássaros, 20 - Guaraú. 11750-000. Peruíbe - SP'
    expect(page).to have_content 'Telefone: (13)99754-7634'
    expect(page).to have_content 'E-mail: dafloresta@gmail.com'
    expect(page).to have_content 'Check_in: 13:00 - Check_out: 14:00'
    expect(page).to have_content 'pet: true'
    expect(page).to have_content 'Politicas de Uso: não fumar, limpar após o uso'
    expect(page).to have_content 'Métodos de pagamento: Débito, Crédito, Pix e dinheiro'
    expect(page).to have_content 'Status: active'
    expect(page).to have_content 'Não há quartos vagos'
    expect(page).to have_content 'Editar'
    expect(page).to have_content 'Alterar Status: active'
    expect(page).to have_content 'Cadastrar Quarto'
    expect(page).to have_current_path('/inns/1') 
  end

  it 'que não é a sua e não encontra os controles de host (Editar, Alterar Status, Cadastrar Quarto)' do
    # Arrange
    host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    Inn.create!(corporate_name: 'Pousadas Guaraú', brand_name: 'Pousada na floresta',
                registration_number: '88.297.902/0001-82', phone_number: '(13)99754-7634',
                email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú',
                city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
                description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro',
                pet_friendly: true, usage_policy: 'não fumar, limpar após o uso',
                check_in: '13:00:00', check_out: '14:00:00', host_id: 1)
    Host.create!(name: 'Maria', email: 'maria@gmail.com', password: '123456')
    Inn.create!(corporate_name: 'Pousadas da Maria', brand_name: 'Pousadinha',
                registration_number: '81.664.477/0001-73', phone_number: '(11)99432-7136',
                email: 'pousadinha@gmail.com', address: 'Rua das flores, 56', neighborhood: 'Guaraú',
                city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
                description: 'O lugar mais bonito para ficar', payment_methods: 'Débito, Crédito, Pix e dinheiro',
                pet_friendly: false, usage_policy: 'não fazer barulhos altos',
                check_in: '15:00:00', check_out: '16:00:00', host_id: 2)
    
        login_as host, scope: :host

    login_as host, scope: :host
    visit(root_path)
    click_on('Pousadinha')
    
    # Assert
    expect(page).to have_content 'Sair'
    expect(page).to have_content 'Pousadinha'
    expect(page).to have_content 'O lugar mais bonito para ficar'
    expect(page).to have_content 'Endereço: Rua das flores, 56 - Guaraú. 11750-000. Peruíbe - SP'
    expect(page).to have_content 'Telefone: (11)99432-7136'
    expect(page).to have_content 'E-mail: pousadinha@gmail.com'
    expect(page).to have_content 'Check_in: 15:00 - Check_out: 16:00'
    expect(page).to have_content 'Aceita pet: false'
    expect(page).to have_content 'Politicas de Uso: não fazer barulhos altos'
    expect(page).to have_content 'Métodos de pagamento: Débito, Crédito, Pix e dinheiro'
    expect(page).to have_content 'Não há quartos vagos'
    expect(page).not_to have_content 'Editar'
    expect(page).not_to have_content 'Alterar Status'
    expect(page).not_to have_content 'Cadastrar Quarto'
    expect(page).to have_current_path('/inns/2') 
  end

  it 'que é a sua e altera seu Status com sucesso' do
    # Arrange
    host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    Inn.create!(corporate_name: 'Pousadas Guaraú', brand_name: 'Pousada na floresta',
                registration_number: '88.297.902/0001-82', phone_number: '(13)99754-7634',
                email: 'dafloresta@gmail.com', address: 'Rua dos pássaros, 20', neighborhood: 'Guaraú',
                city: 'Peruíbe', state: 'SP', postal_code: '11750-000',
                description: 'Uma pousada com muita natureza', payment_methods: 'Débito, Crédito, Pix e dinheiro',
                pet_friendly: true, usage_policy: 'não fumar, limpar após o uso',
                check_in: '13:00:00', check_out: '14:00:00', host_id: 1)
        login_as host, scope: :host

    # Act
    login_as host, scope: :host
    visit(root_path)
    click_on('Pousada na floresta')
    click_on 'Alterar Status'
    
    # Assert
    expect(page).to have_content('Status: inactive')
  end
end