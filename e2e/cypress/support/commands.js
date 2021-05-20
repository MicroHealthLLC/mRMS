
// Login command
Cypress.Commands.add("login", (email, password) => {
  cy.visit('/')
  cy.get('#user_login').type(email, {force: true}).should('have.value', email)
  cy.get('#user_password').type(password, {force: true}).should('have.value', password)
  cy.get('.d-inline-flex').click({force: true})
  cy.get('.btn').click({force: true})
})

// Logout Command
Cypress.Commands.add("logout", () => {
  cy.get('[data-cy=logout]').click()
  cy.get('#flash_notice').contains('Signed out successfully.')
})
