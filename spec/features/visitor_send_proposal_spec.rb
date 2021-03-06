require 'rails_helper'

feature 'visitor_send_proposal' do
  scenario 'successfully' do
    #cria os dados necessarios
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', daily_rate: 50, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '05/09/2017'
    fill_in 'Data Final', with: '10/09/2017'
    fill_in 'Quantidade de hóspedes', with: '4'
    fill_in 'Nome', with: 'Fernando da Silva'
    fill_in 'Email', with: 'fernado@silva.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11)99899-0909'
    fill_in 'Observações', with: 'Pretendo levar dois cachorros e um gato'

    click_on 'Enviar'

    expect(page).to have_css('li', text: '05/09/2017')
    expect(page).to have_css('li', text: '10/09/2017')
    expect(page).to have_css('li', text: 'Valor total: R$ 250,00')
  end

  scenario 'and missing some attribute' do
    #criando os dados necessarios
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: ''
    fill_in 'Data Final', with: ''
    fill_in 'Nome',  with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'Observações', with: ''
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Houve um erro ao tentar enviar a proposta')
  end

  scenario 'and start date < today' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017-07-10'
    fill_in 'Data Final', with: '2017-07-15'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Data inicial deve ser maior do que a data de hoje')

  end
  scenario 'and end date < start date' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: Date.today + 1
    fill_in 'Data Final', with: '2017-07-09'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: 'Data final deve ser maior do que a data inicial')
  end

  scenario 'and total days < minimun rent' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', minimun_rent: 1, maximum_rent: 5, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017-09-11'
    fill_in 'Data Final', with: '2017-09-11'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: "Quantidade de dias para hospedagem precisa ser maior que #{property.minimun_rent}")
  end

  scenario 'and total days > maximumn rent' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', minimun_rent: 1, maximum_rent: 5, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '2017-09-11'
    fill_in 'Data Final', with: '2017-09-18'
    fill_in 'Quantidade de hóspedes', with: 5
    fill_in 'Nome', with: 'Carlos Alberto'
    fill_in 'Email', with: 'carlos.alberto@gmail.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11) 99899-0909'
    fill_in 'Observações', with: 'Pretendo levar um cachorro'
    click_on 'Enviar'

    expect(page).to have_css('label', text: "Quantidade de dias para hospedagem precisa ser menor que #{property.maximum_rent}")
  end

  scenario 'and expect price up to date' do
    owner = create(:user)
    login_as(owner)

    property_type = PropertyType.create(name: 'sitio')
    purpose = Purpose.create(name:'ferias')

    property = create(:property, city: 'Sao Paulo', minimun_rent: 1, maximum_rent: 5, property_type: property_type, owner_id: owner.id)

    PropertyPurpose.create(property: property, purpose: purpose)

    daily_price_range = PriceRange.create(start_date: Date.today, end_date: Date.today + 30, daily_rate: 100, property_id: property.id)

    visit root_path
    click_on property.title
    click_on 'Enviar Proposta'

    fill_in 'Data Inicial', with: '05/09/2017'
    fill_in 'Data Final', with: '10/09/2017'
    fill_in 'Quantidade de hóspedes', with: '4'
    fill_in 'Nome', with: 'Fernando da Silva'
    fill_in 'Email', with: 'fernado@silva.com'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Telefone', with: '(11)99899-0909'
    fill_in 'Observações', with: 'Pretendo levar dois cachorros e um gato'

    click_on 'Enviar'

    expect(page).to have_css('li', text: '05/09/2017')
    expect(page).to have_css('li', text: '10/09/2017')
    expect(page).to have_css('li', text: 'Valor total: R$ 500,00')
  end

end
