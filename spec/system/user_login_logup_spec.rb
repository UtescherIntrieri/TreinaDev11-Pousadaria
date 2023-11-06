require 'rails_helper'

describe 'Usuário faz login' do
  it 'sem se cadastrar/com dados incorretos' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'joao@gmail.com' 
    fill_in 'Senha', with: '123456' 
    within 'form' do
      click_on 'Entrar'
    end
    
    # Assert
    expect(page).to have_content('E-mail ou senha inválidos') 
  end

  it 'pela tela de cadastro e esquece de confirmar a senha' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'João' 
    fill_in 'E-mail', with: 'joao@gmail.com' 
    fill_in 'Senha', with: '123456' 
    within 'form' do
      click_on 'Criar'
    end
    
    # Assert
    expect(page).to have_content('Confirme sua senha não é igual a Senha')
    expect(page).to have_content('Não foi possível salvar anfitrião')
    expect(page).to have_content('Criar conta')
  end

  it 'pela tela de cadastro' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'João' 
    fill_in 'E-mail', with: 'joao@gmail.com' 
    fill_in 'Senha', with: '123456' 
    fill_in 'Confirme sua senha', with: '123456' 
    click_on 'Criar'
    
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
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'João' 
    fill_in 'E-mail', with: 'joao@gmail.com' 
    fill_in 'Senha', with: '123456' 
    fill_in 'Confirme sua senha', with: '123456' 
    click_on 'Criar'
    visit root_path
    expect(page).to have_current_path('/inns/new') 
    
    # Assert
    expect(page).to have_content('João') 
    expect(page).to have_content('Sair') 
    expect(page).not_to have_content('Entrar') 
    expect(page).to have_content('Cadastrar Pousada') 
  end
end