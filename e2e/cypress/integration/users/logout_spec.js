describe('Logout', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.appScenario('basic')
  })

  it('Logout current user and redirect to sign in page', function() {
    cy.login('admin', 'T3$tAdmin')
    cy.get('#flash_notice').contains('Signed in successfully.')
    cy.logout()
    cy.contains('Sign In')
  })
})
