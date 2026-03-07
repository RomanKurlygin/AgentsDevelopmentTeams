# Create-PRD — Шаблон и инструкция по созданию PRD

> Этот документ предназначен для людей и AI-агентов (в т.ч. Cursor).
> Критерии приёмки заданы в формате GIVEN/WHEN/THEN для прямой связи с тестами.
> Основано на практиках agentic product development и контекстной разработке.

---

## Инструкция по использованию

1. Для каждой новой фичи создайте PRD на основе этого шаблона.
2. Сохраняйте файл как `docs/prds/PRD-[feature-name].md`.
3. Заполните все разделы; неизвестное помечайте как `[TBD]`.
4. После согласования PRD считается источником истины для реализации.

**Для Cursor:** при запросе «создай PRD для [название фичи]» используйте структуру ниже и сохраните результат в `docs/prds/PRD-[feature-name].md`.

---

# PRD: [Feature/Product Name]

**Status**: Draft | In Review | Approved | In Progress | Complete  
**Author**: [Name or Agent]  
**Created**: YYYY-MM-DD  
**Last Updated**: YYYY-MM-DD  
**Priority**: P0 (critical) | P1 (high) | P2 (medium) | P3 (low)  
**Reviewers**: [Names]

---

## 1. Objective

[1–2 предложения: что мы делаем и зачем? Какую проблему пользователя решаем?]

### Mission

[Миссия продукта для этой фичи. Какому принципу она служит?]

### Core Principles

1. [Принцип 1]
2. [Принцип 2]
3. [Принцип 3]

---

## 2. Problem Statement

### What problem are we solving?

[Опишите пользовательскую или бизнес-проблему. Укажите метрики, цитаты из исследований, объёмы обращений в поддержку, пробелы относительно конкурентов.]

### Who has this problem?

[Целевая аудитория: персоны, сценарии, уровень экспертизы, контекст.]

### How do we know this is real?

[Данные: исследования, аналитика, обратная связь, рынок. Оцените влияние.]

### What happens if we don't solve it?

[Последствия бездействия: отток, потери выручки, проигрыш конкурентам.]

---

## 3. Target Users

[Кто получает выгоду от фичи? Какой у них уровень технической подготовки? Ключевые потребности?]

---

## 4. User Stories

### US-1: [Imperative Title]

**As a** [persona]  
**I want to** [action]  
**So that** [benefit]

**Acceptance Criteria:**

```
GIVEN [precondition]
WHEN [action]
THEN [expected result]
AND [additional assertion]
```

```
GIVEN [precondition]
WHEN [action]
THEN [expected result]
```

**Examples:**

| Input | Expected Output |
|-------|-----------------|
| `{"email": "valid@test.com"}` | `{"status": 201, "id": "usr_xxx"}` |
| `{"email": ""}` | `{"status": 400, "error": "Email required"}` |

**Complexity**: S (hours) | M (1–2 days) | L (3–5 days)  
**Dependencies**: None

---

### US-2: [Imperative Title]

**As a** [persona]  
**I want to** [action]  
**So that** [benefit]

**Acceptance Criteria:**

```
GIVEN [precondition]
WHEN [action]
THEN [expected result]
```

**Complexity**: S | M | L  
**Dependencies**: US-1

---

## 5. Scope

### In Scope

- [Фича/возможность 1]
- [Фича/возможность 2]

### Out of Scope

- [Исключённый пункт 1] — Причина: [почему]
- [Исключённый пункт 2] — Причина: [почему]

### Future Considerations

- [Возможное развитие позже]

> **Правило для агента:** не реализовывать пункты из «Out of Scope» и «Future Considerations».

---

## 6. Technical Context

### Relevant Files

| File | Purpose |
|------|---------|
| `[path]/[file]` | Логика для расширения |
| `[path]/[file]` | Модель данных для изменения |
| `[test path]/[file]` | Существующие паттерны тестов |

### Existing Patterns to Follow

```
// Вставьте реальный фрагмент кода из проекта, который агент должен повторять
```

### Data Model Changes (if applicable)

```
-- Опишите изменения схемы при необходимости
```

### API Changes (if applicable)

```
METHOD /endpoint
  Request:  { field: type }
  Response: { field: type }
  Errors:   [relevant error codes]
```

### Constraints

- [Техническое ограничение, напр. совместимость с текущей авторизацией]
- [Ограничение по производительности, напр. p95 < 200ms]
- [Совместимость, напр. Safari 14+]

### Dependencies

| Dependency | Owner | Status | Risk if Delayed |
|------------|-------|--------|-----------------|
| [API/service] | [team] | [status] | [impact] |

---

## 7. Design & UX

### User Flow

```
[Шаг 1: действие пользователя] → [Шаг 2: ответ системы] → [Шаг 3: ...] → Done
```

### Wireframes / Mockups

[Ссылка на макеты или краткое описание раскладки]

### Accessibility Requirements

- Соответствие WCAG 2.1 AA
- Управление с клавиатуры
- Поддержка скринридеров
- Контраст текста >= 4.5:1

### Error States

| Error Condition | User-Facing Message | Recovery Action |
|-----------------|---------------------|-----------------|
| [condition] | [message] | [what user can do] |

---

## 8. Non-Functional Requirements

| Requirement | Target | How to Validate |
|-------------|--------|-----------------|
| API latency | < 200ms p95 | Load test |
| Test coverage | > 80% new code | Coverage command |
| Accessibility | WCAG 2.1 AA | Axe audit |
| Uptime | 99.9% | Monitoring |

---

## 9. Success Metrics

### Primary Metrics (must move)

| Metric | Baseline | Target | How Measured |
|--------|----------|--------|--------------|
| [metric] | [value] | [target] | [method] |

### Guardrail Metrics (must not regress)

- [Напр.: время загрузки страницы < X ms]
- [Напр.: доля ошибок < X%]
- [Напр.: фича Y продолжает работать]

---

## 10. Implementation Phases

Фазы согласуйте с общим планом проекта (например, `PROJECT.md`). Ниже — пример для этой фичи.

### Phase 1: [Name — e.g., Data Layer]

1. [Конкретная задача]
2. [Написать тесты для этой фазы]

**Validation:** запуск команды валидации из проекта

### Phase 2: [Name — e.g., Service Layer]

1. [Конкретная задача]
2. [Написать тесты]

**Validation:** запуск команды валидации из проекта

### Phase 3+: [при необходимости]

---

## 11. Rollout Plan

| Phase | Audience | Advance Criteria | Rollback Trigger |
|-------|----------|------------------|------------------|
| Alpha | Internal | No P0 bugs | Any data loss |
| Beta | 10% users | Metrics OK | Error rate > 5% |
| GA | 100% | Beta criteria met | Per incident |

### Feature Flags

- Flag: `[feature_flag_name]`
- Default: off
- Rollout: по проценту трафика

---

## 12. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [risk] | High/Med/Low | High/Med/Low | [strategy] |

---

## 13. Open Questions

| # | Question | Owner | Due Date | Resolution |
|---|----------|-------|----------|------------|
| 1 | [question] | [who] | [date] | [TBD] |

---

## 14. Boundaries

### ALWAYS (агент может делать свободно)

- Запускать тесты, линтеры, проверки типов
- Создавать/редактировать файлы в рамках этой фичи
- Следовать паттернам из кодовой базы

### ASK FIRST (нужно согласование)

- Добавлять новые зависимости
- Менять схемы БД сверх описанного выше
- Менять общие интерфейсы

### NEVER

- Менять существующие миграции
- Коммитить секреты и учётные данные
- Пропускать написание тестов
- Обходить правила типобезопасности проекта

---

## 15. Success Criteria

### Functional

- [ ] Все критерии приёмки из user stories выполнены
- [ ] API возвращает ожидаемые коды и контракты
- [ ] Ошибки обработаны и показаны пользователю

### Quality

- [ ] Покрытие тестами > 80% по новому коду
- [ ] Соблюдены правила типобезопасности
- [ ] Линт и проверки типов проходят

### User Experience

- [ ] [Конкретные UX-цели для фичи]

---

## 16. Validation Checklist

- [ ] У всех критериев приёмки есть проходящие тесты
- [ ] Команда валидации проекта проходит
- [ ] Правила типобезопасности соблюдены
- [ ] Нет секретов в коде
- [ ] Миграция обратима (если применимо)
- [ ] Success criteria выполнены
- [ ] Code review пройден

---

## Appendix

### Glossary

| Term | Definition |
|------|------------|
| [term] | [definition] |

### Related Documents

- [Ссылка на дизайн]
- [Ссылки на смежные PRD]

### Revision History

| Date | Author | Changes |
|------|--------|--------|
| YYYY-MM-DD | [name] | Initial draft |

---

## Agent Processing Notes

> Помогают агентам корректно интерпретировать и выполнять PRD.

### For Architect Agent

- Фокус на Technical Context, изменениях API и модели данных
- Ограничения задают технологический выбор
- Зависимости задают порядок интеграции

### For Implementer Agent

- User Stories задают ЧТО строить
- Acceptance Criteria задают КОГДА готово
- Scope задаёт границы — «Out of Scope» соблюдать строго
- Implementation Phases задают ПОРЯДОК работ

### For Tester Agent

- Каждый GIVEN/WHEN/THEN — минимум один тест-кейс
- Таблица Error States — негативные тесты
- NFR задают цели по производительности
- Guardrail Metrics — требования к регрессионным тестам

### For Security Agent

- Проверить изменения модели данных на риски приватности/соответствия
- В контрактах API — валидация и авторизация
- Feature flags — проверка на обход авторизации

### For UX Agent

- User Flow задаёт последовательность взаимодействия
- Accessibility Requirements обязательны
- Error States задают все сценарии ошибок для пользователя
