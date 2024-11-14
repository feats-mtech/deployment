import { test, expect } from '@playwright/test';

test.describe('Recipe Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.fill('input[name="username"]', 'bob_lee');
    await page.fill('input[name="password"]', 'password');

    // Click login button
    await page.locator('button[type="submit"]').click();

    // Wait for login response
    await page.waitForResponse((response) => response.url().includes('/authenticate/login'));
  });

  test('Recipe creation', async ({ page }) => {
    // Click the first Recipes button
    await page.locator('a:has-text("Recipes")').nth(0).click();

    // Click Create button
    await page.locator('button:has-text("Create Recipe")').click();

    // expect url to be recipes/details/new
    expect(page.url()).toContain('/recipes/details/new');

    // recipe information
    await page.fill('input[name="name"]', 'mala hotpot');
    await page.click('label:nth-child(3)');
    await page.fill('input[name="cookingTimeInMin"]', '10');
    await page.fill('input[name="image"]', 'https://example.com/image.jpg');
    await page.fill('textarea[name="description"]', 'This is a sample description for the recipe.');
    const dropdownButton = page.locator('button[aria-label="Open"]');
    await dropdownButton.click();
    await page.locator('li[role="option"]:has-text("Chinese")').click();

    // ingredients list
    await page.fill('input[name="ingredient-name"]', 'Mala');
    await page.fill('input[name="quantity"]', '3');
    await page.fill('input[name="uom"]', 'pieces');

    // cooking steps list
    await page.fill('textarea[name="step-description"]', 'Add mala to the pot.');

    await page.locator('#root__layout > div.layout__has__sidebar.MuiBox-root.css-7d7xpv > main > div > div > div > div:nth-child(1) > div > div:nth-child(2) > button:nth-child(1)').click();
    });
});
