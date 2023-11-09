require 'rails_helper'

describe 'Host acessa página de Editar da sua pousada' do
  it 'a partir da página de detalhes' do
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
    visit(root_path)
    login_as(host)
    click_on('Pousada na floresta')
    click_on('Editar')
    
    # Assert
    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_field('Empresa', with: 'Pousadas Guaraú')
    expect(page).to have_field('Nome', with: 'Pousada na floresta')
    expect(page).to have_field('CNPJ', with: '88.297.902/0001-82')
    expect(page).to have_field('Telefone', with: '(13)99754-7634')
    expect(page).to have_field('E-mail', with: 'dafloresta@gmail.com')
    expect(page).to have_field('Endereço', with: 'Rua dos pássaros, 20')
    expect(page).to have_field('Bairro', with: 'Guaraú')
    expect(page).to have_field('Cidade', with: 'Peruíbe')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('CEP', with: '11750-000')
    expect(page).to have_field('Descrição', with: 'Uma pousada com muita natureza')
    expect(page).to have_field('Métodos de pagamento', with: 'Débito, Crédito, Pix e dinheiro')
    expect(page).to have_field('Aceita Pets', checked: true)
    expect(page).to have_field('Políticas de uso', with: 'não fumar, limpar após o uso')
    expect(page).to have_field('Check-in', with: '13:00:00.000')
    expect(page).to have_field('Check-out', with: '14:00:00.000')
  end

  it 'e edita informações com sucesso' do
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
    visit(root_path)
    login_as(host)
    click_on('Pousada na floresta')
    click_on('Editar')

    fill_in 'Nome', with: 'Pousada na montanha'
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content 'Pousada atualizada com sucesso'
    expect(page).to have_content 'Pousada na montanha'
  end

  it 'e falha ao editar uma pousada por não preencher os campos obrigatórios' do
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
    visit(root_path)
    login_as(host)
    click_on('Pousada na floresta')
    click_on('Editar')
    fill_in 'Empresa', with: ''
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Métodos de pagamento', with: ''
    fill_in 'Políticas de uso', with: ''
    fill_in 'Check-in', with: ''
    fill_in 'Check-out', with: ''
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content 'Não foi possível atualizar a pousada'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Empresa não pode ficar em branco'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Bairro não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Métodos de pagamento não pode ficar em branco'
    expect(page).to have_content 'Políticas de uso não pode ficar em branco'
    expect(page).to have_content 'Check-in não pode ficar em branco'
    expect(page).to have_content 'Check-out não pode ficar em branco'
    expect(page).to have_current_path('/inns/1')
  end
end