require 'rails_helper'

describe 'Host acessa /inns/new' do
  it 'e cria uma pousada com sucesso' do
    # Arrange
    host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')

    # Act
    login_as host, scope: :host
    visit root_path
    fill_in 'Empresa', with: 'Pousadas Guaraú'
    fill_in 'Nome', with: 'Pousada na floresta'
    fill_in 'CNPJ', with: '88.297.902/0001-82'
    fill_in 'Telefone', with: '(13)99754-7634'
    fill_in 'E-mail', with: 'dafloresta@gmail.com'
    fill_in 'Endereço', with: 'Rua dos pássaros, 20'
    fill_in 'Bairro', with: 'Guaraú'
    fill_in 'Cidade', with: 'Peruíbe'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '11750-000'
    fill_in 'Descrição', with: 'Uma pousada com muita natureza'
    fill_in 'Métodos de pagamento', with: 'Débito, Crédito, Pix e dinheiro'
    page.check('Aceita Pets')
    fill_in 'Políticas de uso', with: 'não fumar, limpar após o uso'
    fill_in 'Check-in', with: '13:00:00'
    fill_in 'Check-out', with: '14:00:00'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Pousada cadastrada com sucesso.')
    expect(page).to have_content('Pousada na floresta')
    expect(page).to have_content('Peruíbe - SP')
    expect(page).to have_content('Quartos Disponíveis: 0')
    expect(page).to have_current_path(root_path) 
  end
  
  it 'e falha ao criar uma pousada por não preencher os campos obrigatórios' do
    # Arrange
    host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    
    # Act
    login_as host, scope: :host
    visit root_path
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
    expect(page).to have_content 'Pousada não cadastrada.'
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
    expect(page).to have_current_path('/inns') 
    
  end
end