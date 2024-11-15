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

    const saveRecipeButton = page.locator('button:has-text("Save Recipe")');
    await saveRecipeButton.click();
  });

  test('My Recipe Verification', async ({ page }) => {
    // Click the first Recipes button
    await page.locator('a:has-text("My Recipes")').nth(0).click();

    // expect url to be /my-recipes
    expect(page.url()).toContain('/my-recipes');

    const imgElement = page.locator('img[data-id="rimg"]');
    const imgSrc = await imgElement.getAttribute('src');
    expect(imgSrc).toBe('https://example.com/image.jpg');

    const headingElement = page.locator('h6[data-id="rname"]');
    const headingText = await headingElement.innerText();
    expect(headingText).toBe('mala hotpot');

    const descriptionElement = page.locator('p[data-id="rdsc"]');
    const descriptionText = await descriptionElement.innerText();
    expect(descriptionText).toBe('This is a sample description for the recipe.');

    const spanElementCui = page.locator('span[data-id="rcui"]');
    const cuiDescriptionText = await spanElementCui.innerText();
    expect(cuiDescriptionText).toBe('CHINESE');

    const tspanElement = page.locator('div[data-id="rdif"] svg text tspan');
    const tspanText = await tspanElement.textContent();
    expect(tspanText).toBe('2');

    const ratingElement = page.locator('span[data-id="rrating"]');
    const ratingText = await ratingElement.innerText();
    expect(ratingText.trim()).toBe('0');
  });
});
