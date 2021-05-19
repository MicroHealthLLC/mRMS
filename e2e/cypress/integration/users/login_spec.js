describe('Login', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('basic')
  })

  it('Open login page if user not signed in', function() {
    cy.visit('/')
    cy.contains('Sign In')
  })

  it('Test login functionality for admin', function() {
    cy.login('admin', 'T3$tAdmin')
    // cy.contains('Welcome, Test1!')
    // cy.logout()
  })
})
