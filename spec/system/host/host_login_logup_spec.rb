require 'rails_helper'

describe 'Usuário faz login' do
  it 'sem se cadastrar/com dados incorretos e falha' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar Como Host'
    fill_in 'E-mail', with: 'joao@gmail.com' 
    fill_in 'Senha', with: '123456' 
    within('form#new_host') do
      click_on 'Log in'
    end
    
    # Assert
    expect(page).to have_content('E-mail ou senha inválidos') 
  end

  it 'pela tela de cadastro, esquece de confirmar a senha e falha' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar Como Host'
    click_on 'Sign up'
    within ('form#new_host') do
      fill_in 'Nome', with: 'João' 
      fill_in 'E-mail', with: 'joao@gmail.com' 
      fill_in 'Senha', with: '123456' 
      click_on 'Criar'
    end
    
    # Assert
    expect(page).to have_content('Confirme sua senha não é igual a Senha')
    expect(page).to have_content('Não foi possível salvar anfitrião')
    expect(page).to have_content('Host Sign up')
  end

  it 'pela tela de cadastro com sucesso' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar Como Host'
    click_on 'Sign up'
    within ('form#new_host') do
      fill_in 'Nome', with: 'João' 
      fill_in 'E-mail', with: 'joao@gmail.com' 
      fill_in 'Senha', with: '123456' 
      fill_in 'Confirme sua senha', with: '123456' 
      click_on 'Criar'
    end
    # Assert
    expect(page).to have_content('João') 
    expect(page).to have_content('Sair') 
    expect(page).not_to have_content('Entrar') 
    expect(page).to have_current_path('/inns/new') 
  end
  
  it 'pela tela de cadastro, tenta acessar outra rota e é redirecionado para inns/new' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar Como Host'
    click_on 'Sign up'
    within ('form#new_host') do
      fill_in 'Nome', with: 'João' 
      fill_in 'E-mail', with: 'joao@gmail.com' 
      fill_in 'Senha', with: '123456' 
      fill_in 'Confirme sua senha', with: '123456' 
      click_on 'Criar'
    end
    visit root_path
    
    # Assert
    expect(page).to have_content('João') 
    expect(page).to have_content('Sair') 
    expect(page).not_to have_content('Entrar') 
    expect(page).to have_content('Cadastrar Pousada') 
    expect(page).to have_current_path('/inns/new') 
  end
  
  it 'pela tela de login' do
    # Arrange
    Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    
    # Act
    visit root_path
    click_on 'Entrar Como Host'
    within ('form#new_host') do
      fill_in 'E-mail', with: 'joao@gmail.com' 
      fill_in 'Senha', with: '123456' 
      click_on 'Log in'
    end
    
    # Assert
    expect(page).to have_content('João') 
    expect(page).to have_content('Sair') 
    expect(page).not_to have_content('Entrar') 
    expect(page).to have_content('Cadastrar Pousada') 
    expect(page).to have_current_path('/inns/new') 
  end

  it 'e faz logout' do
    # Arrange
    host = Host.create!(name: 'João', email: 'joao@gmail.com', password: '123456')
    
    # Act
    login_as host, scope: :host
    visit root_path
    click_on 'Sair'
    
    # Assert
    expect(page).to have_content('Logout efetuado com sucesso.') 
    expect(page).to have_content('Entrar') 
    expect(page).not_to have_content('Sair') 
    expect(page).to have_current_path('/') 
  end
end