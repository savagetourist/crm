-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 12 2021 г., 06:40
-- Версия сервера: 8.0.24
-- Версия PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `apicrm`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`mysql`@`localhost` PROCEDURE `countLeads` (IN `p1` DATE, IN `p2` DATE)  BEGIN
SELECT
	users.id,
    users.firstname,
    users.lastname,
    COUNT(*) AS CountLeads,
    COUNT(IF(leads.isQualityLead='1', 1, null)) as CountQualityLeads,
    COUNT(IF(leads.isQualityLead='1' AND leads.is_add_sale='1', 1, null)) as CountQualityAssSaleLeads,
    COUNT(IF(leads.isQualityLead='0', 1, null)) as CountNotQualityLeads,
    COUNT(IF(leads.isQualityLead='0' AND leads.is_add_sale='1', 1, null)) as CountNotQualityAssSaleLeads
FROM
    leads
LEFT JOIN users ON(users.id = leads.user_id)
WHERE leads.created_at >= p1 AND leads.created_at <= p2  AND leads.status_id = '3'
GROUP BY users.id, users.firstname, users.lastname;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `leads`
--

CREATE TABLE `leads` (
  `id` bigint UNSIGNED NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `count_create` int NOT NULL DEFAULT '1',
  `is_processed` tinyint(1) NOT NULL DEFAULT '0',
  `isQualityLead` tinyint(1) NOT NULL DEFAULT '0',
  `is_express_delivery` tinyint(1) NOT NULL DEFAULT '0',
  `is_add_sale` tinyint(1) NOT NULL DEFAULT '0',
  `source_id` bigint UNSIGNED DEFAULT NULL,
  `unit_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `status_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `leads`
--

INSERT INTO `leads` (`id`, `phone`, `link`, `count_create`, `is_processed`, `isQualityLead`, `is_express_delivery`, `is_add_sale`, `source_id`, `unit_id`, `user_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, '1111111111', 'http://google.com', 1, 0, 0, 0, 0, 1, 1, 2, 3, '2020-12-29 20:49:08', '2021-08-26 02:57:49'),
(2, NULL, 'http://google.com', 1, 0, 0, 0, 0, 1, 1, 1, 3, '2020-12-31 10:44:50', '2021-08-26 03:12:28'),
(3, '11111111', NULL, 1, 0, 1, 0, 0, 1, 1, 1, 1, '2020-12-31 10:45:19', '2021-08-26 22:09:59'),
(4, NULL, 'http://site.com', 1, 0, 1, 0, 0, 1, 1, 1, 3, '2021-01-25 19:52:08', '2021-01-25 19:52:08'),
(5, NULL, 'http://site.com', 1, 0, 1, 0, 0, 1, 1, 1, 3, '2021-01-25 19:52:47', '2021-01-25 19:52:47'),
(6, NULL, 'http://site.com', 3, 0, 1, 0, 0, 2, 2, 2, 3, '2021-01-25 19:54:24', '2021-01-27 18:57:18'),
(7, NULL, 'http://laravel.com', 1, 0, 0, 0, 0, 1, 1, 1, 3, '2021-08-20 04:25:31', '2021-08-25 21:38:00'),
(8, NULL, 'seffsf', 1, 0, 0, 0, 0, 4, 3, 1, 3, '2021-08-20 04:36:59', '2021-08-26 04:07:40'),
(9, NULL, 'saffafaf', 2, 0, 1, 0, 0, 2, 2, 1, 3, '2021-08-20 04:39:49', '2021-09-03 02:03:46'),
(10, NULL, 'ssylka', 1, 0, 0, 0, 0, 4, 3, 1, 3, '2021-08-20 04:47:04', '2021-08-25 21:52:48'),
(11, NULL, 'ссылка', 1, 0, 0, 0, 0, 1, 1, 1, 3, '2021-08-21 02:07:48', '2021-08-25 21:42:58'),
(12, NULL, 'asasdsadsadsads', 1, 0, 0, 0, 0, 2, 1, 1, 3, '2021-08-21 02:20:03', '2021-08-26 02:42:26'),
(13, NULL, 'td', 1, 0, 0, 0, 0, 3, 2, 1, 1, '2021-08-21 02:38:52', '2021-08-21 02:38:52'),
(14, NULL, 'FDHTS', 1, 1, 0, 1, 1, 3, 2, 1, 1, '2021-08-21 02:42:52', '2021-08-21 02:42:52'),
(15, '2342342', NULL, 1, 0, 0, 0, 0, 4, 2, 1, 1, '2021-08-21 02:44:06', '2021-08-21 02:44:06'),
(16, '335367567', NULL, 1, 0, 0, 0, 0, 3, 3, 1, 3, '2021-08-21 02:46:02', '2021-08-26 04:10:47'),
(17, NULL, 'RTTYY', 1, 0, 0, 0, 1, 3, 3, 1, 3, '2021-08-21 02:51:18', '2021-08-26 03:17:48'),
(18, '3344535', NULL, 1, 1, 0, 0, 1, 4, 3, 1, 2, '2021-08-21 02:54:12', '2021-08-21 02:54:12'),
(19, NULL, 'кккккккккккккккккккккккк', 1, 1, 0, 1, 1, 4, 2, 1, 3, '2021-08-21 02:54:51', '2021-08-26 20:25:50'),
(20, NULL, 'ееееееееееееееееееееееееееееееееее', 1, 1, 0, 0, 1, 4, 3, 1, 1, '2021-08-21 02:55:32', '2021-08-21 02:55:32'),
(21, NULL, 'ываыва', 1, 0, 0, 1, 1, 4, 3, 1, 2, '2021-08-21 02:58:44', '2021-08-21 02:58:44'),
(22, NULL, 'ваваарпавапр', 1, 1, 0, 1, 1, 2, 2, 1, 3, '2021-08-24 04:56:11', '2021-08-21 02:59:16'),
(23, NULL, 'http.google.com', 1, 1, 0, 1, 1, 3, 3, 1, 3, '2021-08-23 04:55:58', '2021-08-25 01:47:18'),
(24, NULL, 'ssdsd', 1, 1, 1, 1, 1, 4, 3, 1, 3, '2021-08-24 21:56:44', '2021-08-24 21:56:44'),
(25, NULL, '1111', 1, 0, 1, 1, 1, 4, 3, 1, 3, '2021-08-26 21:16:37', '2021-08-26 21:31:29'),
(26, NULL, 'Новенький лидочек', 1, 0, 1, 0, 0, 1, 1, 1, 3, '2021-08-27 01:16:48', '2021-08-27 01:18:55'),
(27, NULL, '11111111', 1, 0, 0, 0, 0, 3, 2, 1, 1, '2021-08-27 02:21:59', '2021-08-27 02:21:59');

-- --------------------------------------------------------

--
-- Структура таблицы `lead_comments`
--

CREATE TABLE `lead_comments` (
  `id` bigint UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `lead_id` bigint UNSIGNED DEFAULT NULL,
  `status_id` bigint UNSIGNED DEFAULT NULL,
  `comment_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_event` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `lead_comments`
--

INSERT INTO `lead_comments` (`id`, `text`, `user_id`, `lead_id`, `status_id`, `comment_value`, `is_event`, `created_at`, `updated_at`) VALUES
(1, 'Автор <strong> admin</strong> создал лид со статусом Новые заявки', 1, 4, 1, NULL, 1, '2021-01-25 19:52:08', '2021-01-25 19:52:08'),
(2, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 4, 1, NULL, 0, '2021-01-25 19:52:08', '2021-01-25 19:52:08'),
(3, 'Автор <strong> admin</strong> создал лид со статусом Новые заявки', 1, 5, 1, NULL, 1, '2021-01-25 19:52:47', '2021-01-25 19:52:47'),
(4, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 5, 1, NULL, 0, '2021-01-25 19:52:47', '2021-01-25 19:52:47'),
(5, 'Автор <strong> admin</strong> создал лид со статусом Новые заявки', 1, 6, 1, NULL, 1, '2021-01-25 19:54:24', '2021-01-25 19:54:24'),
(6, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 6, 1, 'Hello world', 0, '2021-01-25 19:54:24', '2021-01-25 19:54:24'),
(7, 'Пользователь <strong> admin</strong> оставил комментарий Hello world', 1, 6, 1, 'Hello world', 0, '2021-01-26 19:48:46', '2021-01-26 19:48:46'),
(8, 'Пользователь <strong> admin</strong> изменил статус лида В работе', 1, 6, 2, NULL, 1, '2021-01-26 19:49:10', '2021-01-26 19:49:10'),
(9, 'Пользователь <strong> admin</strong> изменил автора лида на  Manager', 1, 6, 2, NULL, 1, '2021-01-26 19:49:56', '2021-01-26 19:49:56'),
(10, 'Пользователь  admin оставил комментарий Hello world', 1, 6, 1, 'Hello world', 0, '2021-01-26 20:10:34', '2021-01-26 20:10:34'),
(11, 'Пользователь  admin изменил статус на Новые заявки', 1, 6, 1, NULL, 1, '2021-01-26 20:10:34', '2021-01-26 20:10:34'),
(12, 'Автор  admin создал лид  со статусом Новые заявки', 1, 6, 1, 'Hello world', 1, '2021-01-26 20:10:34', '2021-01-26 20:10:34'),
(13, 'Пользователь  admin оставил комментарий Hello world 2', 1, 6, 1, 'Hello world 2', 0, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(14, 'Пользователь  admin изменил источник на Viber', 1, 6, 1, NULL, 1, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(15, 'Пользователь  admin изменил подразделение на Shop 2', 1, 6, 1, NULL, 1, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(16, 'Автор  admin создал лид  со статусом Новые заявки', 1, 6, 1, 'Hello world 2', 1, '2021-01-26 20:11:46', '2021-01-26 20:11:46'),
(17, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 7, 1, NULL, 1, '2021-08-20 04:25:31', '2021-08-20 04:25:31'),
(18, 'Пользователь <strong> admin</strong> оставил комментарий: sdfsdf', 1, 7, 1, 'sdfsdf', 0, '2021-08-20 04:25:31', '2021-08-20 04:25:31'),
(19, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 8, 1, NULL, 1, '2021-08-20 04:36:59', '2021-08-20 04:36:59'),
(20, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 9, 1, NULL, 1, '2021-08-20 04:39:49', '2021-08-20 04:39:49'),
(21, 'Пользователь <strong> admin</strong> оставил комментарий: SDFGHJKL', 1, 9, 1, 'SDFGHJKL', 0, '2021-08-20 04:39:49', '2021-08-20 04:39:49'),
(22, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 10, 1, NULL, 1, '2021-08-20 04:47:04', '2021-08-20 04:47:04'),
(23, 'Пользователь <strong> admin</strong> оставил комментарий: Comment1', 1, 10, 1, 'Comment1', 0, '2021-08-20 04:47:04', '2021-08-20 04:47:04'),
(24, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 11, 1, NULL, 1, '2021-08-21 02:07:48', '2021-08-21 02:07:48'),
(25, 'Пользователь <strong> admin</strong> оставил комментарий: новый1', 1, 11, 1, 'новый1', 0, '2021-08-21 02:07:48', '2021-08-21 02:07:48'),
(26, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 12, 1, NULL, 1, '2021-08-21 02:20:03', '2021-08-21 02:20:03'),
(27, 'Пользователь <strong> admin</strong> оставил комментарий: asdadad', 1, 12, 1, 'asdadad', 0, '2021-08-21 02:20:03', '2021-08-21 02:20:03'),
(28, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 13, 1, NULL, 1, '2021-08-21 02:38:52', '2021-08-21 02:38:52'),
(29, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 14, 1, NULL, 1, '2021-08-21 02:42:52', '2021-08-21 02:42:52'),
(30, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 15, 1, NULL, 1, '2021-08-21 02:44:06', '2021-08-21 02:44:06'),
(31, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 16, 1, NULL, 1, '2021-08-21 02:46:02', '2021-08-21 02:46:02'),
(32, 'Пользователь <strong> admin</strong> оставил комментарий: TYYYYYYYYYYYYYYYYY', 1, 16, 1, 'TYYYYYYYYYYYYYYYYY', 0, '2021-08-21 02:46:02', '2021-08-21 02:46:02'),
(33, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 17, 1, NULL, 1, '2021-08-21 02:51:18', '2021-08-21 02:51:18'),
(34, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 18, 1, NULL, 1, '2021-08-21 02:54:12', '2021-08-21 02:54:12'),
(35, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 19, 1, NULL, 1, '2021-08-21 02:54:51', '2021-08-21 02:54:51'),
(36, 'Пользователь <strong> admin</strong> оставил комментарий: ДА!', 1, 19, 1, 'ДА!', 0, '2021-08-21 02:54:51', '2021-08-21 02:54:51'),
(37, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 20, 1, NULL, 1, '2021-08-21 02:55:32', '2021-08-21 02:55:32'),
(38, 'Пользователь <strong> admin</strong> оставил комментарий: ппппппппп', 1, 20, 1, 'ппппппппп', 0, '2021-08-21 02:55:32', '2021-08-21 02:55:32'),
(39, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 21, 1, NULL, 1, '2021-08-21 02:58:44', '2021-08-21 02:58:44'),
(40, 'Пользователь <strong> admin</strong> оставил комментарий: ыааа', 1, 21, 1, 'ыааа', 0, '2021-08-21 02:58:44', '2021-08-21 02:58:44'),
(41, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 22, 1, NULL, 1, '2021-08-21 02:59:16', '2021-08-21 02:59:16'),
(42, 'Пользователь <strong> admin</strong> оставил комментарий: ввыапывап', 1, 22, 1, 'ввыапывап', 0, '2021-08-21 02:59:16', '2021-08-21 02:59:16'),
(43, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 23, 1, NULL, 1, '2021-08-23 01:47:18', '2021-08-23 01:47:18'),
(44, 'Пользователь <strong> admin</strong> оставил комментарий: Проверка лида на создание и отображение его в таблице', 1, 23, 1, 'Проверка лида на создание и отображение его в таблице', 0, '2021-08-23 01:47:18', '2021-08-23 01:47:18'),
(45, 'Автор <strong> admin</strong> создал лид со статусом: Новые заявки', 1, 24, 1, NULL, 1, '2021-08-24 21:56:44', '2021-08-24 21:56:44'),
(46, 'Пользователь <strong> admin</strong> оставил комментарий: sdfsfsf', 1, 24, 1, 'sdfsfsf', 0, '2021-08-24 21:56:44', '2021-08-24 21:56:44'),
(47, 'Пользователь <strong> admin</strong> изменил статус лида на: В работе', 1, 2, 2, NULL, 1, '2021-08-25 21:14:31', '2021-08-25 21:14:31'),
(48, 'Пользователь <strong> admin</strong> оставил комментарий: Test process', 1, 2, 2, 'Test process', 0, '2021-08-25 21:14:31', '2021-08-25 21:14:31'),
(49, 'Пользователь <strong> admin</strong> изменил статус лида на: В работе', 1, 3, 2, NULL, 1, '2021-08-25 21:29:00', '2021-08-25 21:29:00'),
(50, 'Пользователь <strong> admin</strong> оставил комментарий: Тест перемещения', 1, 3, 2, 'Тест перемещения', 0, '2021-08-25 21:29:00', '2021-08-25 21:29:00'),
(51, 'Пользователь <strong> admin</strong> изменил статус лида на: В работе', 1, 10, 2, NULL, 1, '2021-08-25 21:30:44', '2021-08-25 21:30:44'),
(52, 'Пользователь <strong> admin</strong> оставил комментарий: Тест перемещения 2', 1, 10, 2, 'Тест перемещения 2', 0, '2021-08-25 21:30:44', '2021-08-25 21:30:44'),
(53, 'Пользователь <strong> admin</strong> изменил статус лида на: Выполнено', 1, 7, 3, NULL, 1, '2021-08-25 21:38:00', '2021-08-25 21:38:00'),
(54, 'Пользователь <strong> admin</strong> оставил комментарий: Проверка окошка уведомления', 1, 7, 3, 'Проверка окошка уведомления', 0, '2021-08-25 21:38:00', '2021-08-25 21:38:00'),
(55, 'Пользователь <strong> admin</strong> изменил статус лида на: В работе', 1, 8, 2, NULL, 1, '2021-08-25 21:42:19', '2021-08-25 21:42:19'),
(56, 'Пользователь <strong> admin</strong> оставил комментарий: Проверка сообщения', 1, 8, 2, 'Проверка сообщения', 0, '2021-08-25 21:42:19', '2021-08-25 21:42:19'),
(57, 'Пользователь <strong> admin</strong> изменил статус лида на: Выполнено', 1, 11, 3, NULL, 1, '2021-08-25 21:42:58', '2021-08-25 21:42:58'),
(58, 'Пользователь <strong> admin</strong> оставил комментарий: Проверка сообщения 2', 1, 11, 3, 'Проверка сообщения 2', 0, '2021-08-25 21:42:58', '2021-08-25 21:42:58'),
(59, 'Пользователь <strong> admin</strong> изменил статус лида на: Выполнено', 1, 10, 3, NULL, 1, '2021-08-25 21:52:48', '2021-08-25 21:52:48'),
(60, 'Пользователь <strong> admin</strong> оставил комментарий: Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)', 1, 10, 3, 'Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)  Тест перемещения и текста окошка уведомления и отображения длинного комментария в лиде =)', 0, '2021-08-25 21:52:48', '2021-08-25 21:52:48'),
(61, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 12, 3, NULL, 1, '2021-08-26 02:42:26', '2021-08-26 02:42:26'),
(62, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 1, 3, NULL, 1, '2021-08-26 02:57:49', '2021-08-26 02:57:49'),
(63, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 2, 3, NULL, 1, '2021-08-26 03:12:28', '2021-08-26 03:12:28'),
(64, 'Пользователь <strong> admin</strong> оставил комментарий КОМЕНТ КОМЕНТ', 1, 2, 3, 'КОМЕНТ КОМЕНТ', 0, '2021-08-26 03:12:28', '2021-08-26 03:12:28'),
(65, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 17, 3, NULL, 1, '2021-08-26 03:17:48', '2021-08-26 03:17:48'),
(66, 'Пользователь <strong> admin</strong> оставил комментарий Проверка нижнего всплывающего окна', 1, 17, 3, 'Проверка нижнего всплывающего окна', 0, '2021-08-26 03:17:48', '2021-08-26 03:17:48'),
(67, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 8, 3, NULL, 1, '2021-08-26 04:07:40', '2021-08-26 04:07:40'),
(68, 'Пользователь <strong> admin</strong> оставил комментарий ываываы', 1, 8, 3, 'ываываы', 0, '2021-08-26 04:07:40', '2021-08-26 04:07:40'),
(69, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 16, 3, NULL, 1, '2021-08-26 04:10:47', '2021-08-26 04:10:47'),
(70, 'Пользователь <strong> admin</strong> оставил комментарий asdadda', 1, 16, 3, 'asdadda', 0, '2021-08-26 04:10:47', '2021-08-26 04:10:47'),
(71, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 19, 3, NULL, 1, '2021-08-26 20:25:50', '2021-08-26 20:25:50'),
(72, 'Пользователь <strong> admin</strong> оставил комментарий аврврв', 1, 19, 3, 'аврврв', 0, '2021-08-26 20:25:50', '2021-08-26 20:25:50'),
(73, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 3, 3, NULL, 1, '2021-08-26 20:27:22', '2021-08-26 20:27:22'),
(74, 'Пользователь <strong> admin</strong> оставил комментарий авыооаоо', 1, 3, 3, 'авыооаоо', 0, '2021-08-26 20:27:22', '2021-08-26 20:27:22'),
(75, 'Автор  admin создал лид со статусом Новые заявки', 1, 25, 1, NULL, 1, '2021-08-26 21:16:37', '2021-08-26 21:16:37'),
(76, 'Пользователь <strong> admin</strong> оставил комментарий dfhDFHdfhdfh', 1, 20, 1, 'dfhDFHdfhdfh', 0, '2021-08-26 21:28:58', '2021-08-26 21:28:58'),
(77, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 25, 3, NULL, 1, '2021-08-26 21:31:27', '2021-08-26 21:31:27'),
(78, 'Пользователь <strong> admin</strong> оставил комментарий DONE', 1, 25, 3, 'DONE', 0, '2021-08-26 21:31:27', '2021-08-26 21:31:27'),
(79, 'Пользователь <strong> admin</strong> изменил статус лида Новые заявки', 1, 3, 1, NULL, 1, '2021-08-26 22:09:59', '2021-08-26 22:09:59'),
(80, 'Пользователь <strong> admin</strong> оставил комментарий AFSfaf', 1, 3, 1, 'AFSfaf', 0, '2021-08-26 22:09:59', '2021-08-26 22:09:59'),
(81, 'Автор  admin создал лид со статусом Новые заявки', 1, 26, 1, NULL, 1, '2021-08-27 01:16:49', '2021-08-27 01:16:49'),
(82, 'Пользователь  admin оставил комментарий Новенький комментик', 1, 26, 1, 'Новенький комментик', 0, '2021-08-27 01:16:49', '2021-08-27 01:16:49'),
(83, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 26, 3, NULL, 1, '2021-08-27 01:18:53', '2021-08-27 01:18:53'),
(84, 'Пользователь <strong> admin</strong> оставил комментарий Обновл', 1, 26, 3, 'Обновл', 0, '2021-08-27 01:18:53', '2021-08-27 01:18:53'),
(85, 'Автор  admin создал лид со статусом Новые заявки', 1, 27, 1, NULL, 1, '2021-08-27 02:21:59', '2021-08-27 02:21:59'),
(86, 'Пользователь  admin оставил комментарий Обновление лида', 1, 27, 1, 'Обновление лида', 0, '2021-08-27 02:21:59', '2021-08-27 02:21:59'),
(87, 'Пользователь  admin оставил комментарий Обновлние лида должно', 1, 9, 1, 'Обновлние лида должно', 0, '2021-08-27 02:24:16', '2021-08-27 02:24:16'),
(88, 'Пользователь  admin изменил подразделение на Shop 2', 1, 9, 1, NULL, 1, '2021-08-27 02:24:16', '2021-08-27 02:24:16'),
(89, 'Пользователь  admin изменил статус на Новые заявки', 1, 9, 1, NULL, 1, '2021-08-27 02:24:16', '2021-08-27 02:24:16'),
(90, 'Автор  admin создал лид  со статусом Новые заявки', 1, 9, 1, 'Обновлние лида должно', 1, '2021-08-27 02:24:16', '2021-08-27 02:24:16'),
(91, 'Пользователь <strong> admin</strong> оставил комментарий вчлалрпвалопловап', 1, 3, 1, 'вчлалрпвалопловап', 0, '2021-09-03 02:02:25', '2021-09-03 02:02:25'),
(92, 'Пользователь <strong> admin</strong> изменил статус лида Выполнено', 1, 9, 3, NULL, 1, '2021-09-03 02:03:41', '2021-09-03 02:03:41');

-- --------------------------------------------------------

--
-- Структура таблицы `lead_status`
--

CREATE TABLE `lead_status` (
  `id` bigint UNSIGNED NOT NULL,
  `lead_id` bigint UNSIGNED DEFAULT NULL,
  `status_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `lead_status`
--

INSERT INTO `lead_status` (`id`, `lead_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 5, 1, NULL, NULL),
(2, 6, 1, NULL, NULL),
(3, 6, 2, NULL, NULL),
(4, 6, 1, NULL, NULL),
(5, 6, 1, NULL, NULL),
(6, 7, 1, NULL, NULL),
(7, 8, 1, NULL, NULL),
(8, 9, 1, NULL, NULL),
(9, 10, 1, NULL, NULL),
(10, 11, 1, NULL, NULL),
(11, 12, 1, NULL, NULL),
(12, 13, 1, NULL, NULL),
(13, 14, 1, NULL, NULL),
(14, 15, 1, NULL, NULL),
(15, 16, 1, NULL, NULL),
(16, 17, 1, NULL, NULL),
(17, 18, 1, NULL, NULL),
(18, 19, 1, NULL, NULL),
(19, 20, 1, NULL, NULL),
(20, 21, 1, NULL, NULL),
(21, 22, 1, NULL, NULL),
(22, 23, 1, NULL, NULL),
(23, 24, 1, NULL, NULL),
(24, 2, 2, NULL, NULL),
(25, 3, 2, NULL, NULL),
(26, 10, 2, NULL, NULL),
(27, 7, 3, NULL, NULL),
(28, 8, 2, NULL, NULL),
(29, 11, 3, NULL, NULL),
(30, 10, 3, NULL, NULL),
(31, 12, 3, NULL, NULL),
(32, 1, 3, NULL, NULL),
(33, 2, 3, NULL, NULL),
(34, 17, 3, NULL, NULL),
(35, 8, 3, NULL, NULL),
(36, 16, 3, NULL, NULL),
(37, 19, 3, NULL, NULL),
(38, 3, 3, NULL, NULL),
(39, 25, 1, NULL, NULL),
(40, 25, 3, NULL, NULL),
(41, 3, 1, NULL, NULL),
(42, 26, 1, NULL, NULL),
(43, 26, 3, NULL, NULL),
(44, 27, 1, NULL, NULL),
(45, 9, 1, NULL, NULL),
(46, 9, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `menus`
--

CREATE TABLE `menus` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` int NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int NOT NULL DEFAULT '100',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `menus`
--

INSERT INTO `menus` (`id`, `title`, `path`, `parent`, `type`, `sort_order`, `created_at`, `updated_at`) VALUES
(3, 'Dashboard', '/', 0, 'admin', 100, NULL, NULL),
(5, 'Roles', 'roles.index', 0, 'admin', 100, NULL, NULL),
(6, 'Permissions', 'permissions.index', 0, 'admin', 100, NULL, NULL),
(7, 'Users', 'users.index', 0, 'admin', 100, NULL, NULL),
(8, 'Dashboard', '/', 0, 'front', 100, NULL, NULL),
(9, 'Form', 'form', 0, 'front', 100, NULL, NULL),
(10, 'Users', 'users', 0, 'front', 100, NULL, NULL),
(11, 'Sources', 'sources', 0, 'front', 100, NULL, NULL),
(12, 'Units', 'units', 0, 'front', 100, NULL, NULL),
(13, 'Lead Archive', 'archives', 0, 'front', 100, NULL, NULL),
(14, 'Analitics', 'analitics', 0, 'front', 100, NULL, NULL),
(15, 'Tasks', 'tasks', 0, 'front', 100, NULL, NULL),
(16, 'Task Archive', 'task_archives', 0, 'front', 100, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
(6, '2016_06_01_000004_create_oauth_clients_table', 2),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2),
(8, '2020_10_29_213949_create_users_table', 3),
(10, '2020_11_29_124012_create_menus_table', 4),
(11, '2020_12_13_065918_create_roles_table', 5),
(12, '2020_12_13_070523_create_permissions', 5),
(13, '2020_12_13_070544_create_role_permissions', 5),
(14, '2020_12_20_120133_add_permission_menu_table', 6),
(15, '2020_12_26_155516_create_sources_table', 7),
(21, '2020_12_27_084610_create_statuses_table', 8),
(22, '2020_12_27_084612_c_reate_units_t_able', 8),
(23, '2020_12_27_084614_create_leads_table', 8),
(24, '2020_12_27_093705_create_lead_comments_table', 9),
(25, '2021_01_25_214805_create_lead_status_table', 10),
(27, '2021_01_28_210553_create_analitics_table', 11),
(29, '2019_03_25_113115_create_tasks_table', 12),
(30, '2019_03_25_120525_change_task', 12),
(31, '2019_03_25_120925_create_task_comments_table', 13);

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0b6e66385e77a60760c73bfd88d63280df6404884be1384fde9767f282d7ea846f291b09ab6cffbb', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 21:54:23', '2021-08-18 21:54:23', '2021-08-20 08:41:02'),
('10126ac79a66cf0e6d5d289bc747cb2d584431e03138191efac147a004b8b6874018380e364d60de', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 21:17:12', '2021-08-18 21:17:12', '2021-08-20 08:03:52'),
('17dfd9d6874bb6464523686f036893770eac33e949c31e73e1d21112c9dcb5bcc421fe2033f07d29', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 05:05:05', '2021-08-18 05:05:05', '2021-08-19 15:51:45'),
('1a2636babecb44e1c6149a633b65e50231af626b11822236bf0cc83a311171b2d0bde6620f20bbec', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 00:08:12', '2021-08-18 00:08:12', '2022-08-18 07:08:12'),
('4c2cb1bc94f713ae0e805fb3f6bcf527c881f0dc96fff4cbbdf6c3f1a939801e2a17778039795f70', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 21:52:46', '2021-08-18 21:52:46', '2021-08-20 08:39:26'),
('4dcd6cd738bd58c4b975e7872b58cb2f4740853578793212e8a4d3b15c57128cf8896dbe2a374535', 1, 2, NULL, '[]', 0, '2021-08-19 02:02:33', '2021-08-19 02:02:33', '2021-08-20 12:49:13'),
('5f71e727e1097862995b31aaab4c651ba912469aab43a0821bd747a82bd0591b7ffcb4262429ed0b', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 00:47:05', '2021-08-18 00:47:05', '2022-08-18 07:47:05'),
('60b0dbf01cbcfa3bb4fdf2fa7290242e11404082bea3bd2cbbc045704a89503789fbb6391fa35296', 1, 1, 'Personal access Token', '[]', 0, '2021-08-19 22:50:39', '2021-08-19 22:50:39', '2021-08-21 09:37:19'),
('63bfa52f6e627bc18f948cf7081271b06d3e0a050b6e7a8f80dc3f295b9587f58a682c033eb2b0e9', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 21:18:11', '2021-08-18 21:18:11', '2021-08-20 08:04:51'),
('7063e4976bd98aa6fa82a2cb0b49b98e76656556a7d0d7cce3012f5266b9a842e5090648170aab47', 1, 2, NULL, '[]', 0, '2021-08-19 03:26:27', '2021-08-19 03:26:27', '2022-08-01 15:46:27'),
('82352347dda3ed2f3ee5ea21beb3821f2e6305bdae4d61909c4c8f03ca598207a88ea2d1e12e9937', 1, 2, NULL, '[]', 0, '2021-08-18 22:57:12', '2021-08-18 22:57:12', '2021-08-20 09:43:52'),
('83329e4d2c645179a8c44e7b330851d59d486395f82a03622beb6303d4c33c260da822d275c6d5ce', 1, 1, 'Personal access Token', '[]', 0, '2021-08-12 00:09:58', '2021-08-12 00:09:58', '2022-08-12 07:09:58'),
('86b845c40f269b2c369f89bca9512b912d5a750989980758ea7102d27c400d913ae86ef98e85ef56', 1, 1, 'Personal access Token', '[]', 0, '2021-08-26 00:54:43', '2021-08-26 00:54:43', '2021-08-27 11:41:23'),
('97693443221076f2e85a3faf9725085910a1a4f4d2f44914da364ec9b0b7a6da987f8f4072f417e6', 1, 1, 'Personal Access Token', '[]', 0, '2020-11-15 06:41:13', '2020-11-15 06:41:13', '2021-11-15 08:41:13'),
('b14707f3335c341c31dc4a6148df19e992cf9d3f31ca3e4107a2890bffd7f6e03b34a3c4bf8e0a24', 1, 1, 'Personal access Token', '[]', 0, '2021-08-16 00:10:57', '2021-08-16 00:10:57', '2022-08-16 07:10:57'),
('b32c7ca08d6df912ba2a981363a108aedf51aa86e4a80f62032cfd4966e095a27b29f5f62a2ca1fe', 1, 2, NULL, '[]', 0, '2021-08-19 03:19:22', '2021-08-19 03:19:22', '2021-08-19 10:19:25'),
('b367eff545e2a423fc764932dd6bd05ecded6d94dc251ab8aad01fd634da13490c65a426937b0509', 1, 2, NULL, '[]', 0, '2021-08-19 02:07:56', '2021-08-19 02:07:56', '2021-08-19 09:07:59'),
('b73fa4e14430dbd0697fe141871e52a4d375703005e352c40c31d22d61e462b899c5349d2a13f76a', 1, 1, 'Personal access Token', '[]', 0, '2021-08-17 23:16:24', '2021-08-17 23:16:24', '2022-08-18 06:16:24'),
('b8740d02923c2ff0e058e59de1298a987da718fc0270ffc601b09bbb08ade196cfff323af81cb11d', 1, 2, NULL, '[]', 0, '2021-08-19 03:20:25', '2021-08-19 03:20:25', '2021-08-19 10:20:28'),
('d2dd0d1d6ba55b02caf1bb997325fa3a707c44ed3a1f23511dcf0cab4fbf274dc74b20b088667ee0', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-13 04:39:47', '2020-12-13 04:39:47', '2021-12-13 06:39:47'),
('d58437ffc705efca4fe070029b01ab066a6403f59d19f4d72d24fa30f03f5052151fa1cd76caeb44', 1, 1, 'Personal access Token', '[]', 0, '2021-08-17 23:34:53', '2021-08-17 23:34:53', '2022-08-18 06:34:53'),
('e8d90b4f41b76a07916d22e0c5191d848a61d58ea17c30cf37904283d08c9e374eab051739ec0a4b', 1, 2, NULL, '[]', 0, '2021-08-19 03:16:06', '2021-08-19 03:16:06', '2021-08-19 10:16:09'),
('ecdf0fd41280dc7e65e0ef4a58a816f041fd1e585b4a46a67bb97e43dbd7c7fcd98554660c9c70b8', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 06:12:49', '2021-08-18 06:12:49', '2021-08-19 16:59:29'),
('ef690b84a673cddd311d1ea6c013538355ebe2d7df857d5b8725779369865a6212f7249252553360', 1, 1, 'Personal Access Token', '[]', 0, '2020-12-12 05:40:21', '2020-12-12 05:40:21', '2021-12-12 07:40:21'),
('f3205ef35156972daec3e75fc57b9109f1fbb75a1a71ffcbcf507bff7de995d819ce0188a51448e2', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 01:09:15', '2021-08-18 01:09:15', '2022-08-18 08:09:15'),
('f583df329a6bbba4e66accd82845bd351ff66a42d422480b657d47d81cd2a084b69fab9a130e70ed', 1, 1, 'Personal access Token', '[]', 0, '2021-08-18 00:56:02', '2021-08-18 00:56:02', '2022-08-18 07:56:02');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'QO5ywLPb1mHUE1GIeHTkPTL9cEjAQb6H3AQgMBDi', NULL, 'http://localhost', 1, 0, 0, '2020-10-28 19:47:05', '2020-10-28 19:47:05'),
(2, NULL, 'Laravel Password Grant Client', 'w7CMZpxL0I1VimonJ9OD0L4CDHjzRmN6FwU2vgyM', 'users', 'http://localhost', 0, 1, 0, '2020-10-28 19:47:05', '2020-10-28 19:47:05');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-10-28 19:47:05', '2020-10-28 19:47:05');

-- --------------------------------------------------------

--
-- Структура таблицы `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('3be0a28d6d79e2cd701c697f2af3a2eb5665c9d33a9304ae8cb7f9ffeb23e6f65024074d23e2fad6', '82352347dda3ed2f3ee5ea21beb3821f2e6305bdae4d61909c4c8f03ca598207a88ea2d1e12e9937', 0, '2021-09-18 05:57:12'),
('429d0894073f1053bd0d02c80205b917958bd78de533d0d3a1863dfdcd776cda60058a8c354496e1', 'b8740d02923c2ff0e058e59de1298a987da718fc0270ffc601b09bbb08ade196cfff323af81cb11d', 0, '2021-09-18 10:20:25'),
('456361840876d4d0c870bc6357cc2a1ec073fe28453de2465fc448b84e105a69f793af6b0c273765', 'e8d90b4f41b76a07916d22e0c5191d848a61d58ea17c30cf37904283d08c9e374eab051739ec0a4b', 0, '2021-09-18 10:16:06'),
('a89ae674d2c246c64a78b8d585a693bbb07ec23d52ae9ffdfc5710e01eff2a34292ac7b4f4d74dbb', '4dcd6cd738bd58c4b975e7872b58cb2f4740853578793212e8a4d3b15c57128cf8896dbe2a374535', 0, '2021-09-18 09:02:33'),
('ae0c997dca54599fe5153b7afc0010a33f2422ed97993c025db1efea1fa53c5c2952f9be3efe2e80', 'b367eff545e2a423fc764932dd6bd05ecded6d94dc251ab8aad01fd634da13490c65a426937b0509', 0, '2021-09-18 09:07:56'),
('bbd5d72f1c408b6138e0a587f0c6b7740cfd9c589c6918395269945e4f5e31e246d42f7782fe7995', 'b32c7ca08d6df912ba2a981363a108aedf51aa86e4a80f62032cfd4966e095a27b29f5f62a2ca1fe', 0, '2021-09-18 10:19:22'),
('e7b92149346b1ddcd09fecd187579b9337d37b0f6fcfb643d19c2d51d1284ad8bf83a63828886b27', '7063e4976bd98aa6fa82a2cb0b49b98e76656556a7d0d7cce3012f5266b9a842e5090648170aab47', 0, '2021-09-18 10:26:27');

-- --------------------------------------------------------

--
-- Структура таблицы `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `permissions`
--

CREATE TABLE `permissions` (
  `id` int UNSIGNED NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permissions`
--

INSERT INTO `permissions` (`id`, `alias`, `title`, `created_at`, `updated_at`) VALUES
(1, 'SUPER_ADMINISTRATOR', 'Super Administrator', NULL, NULL),
(2, 'ROLES_ACCESS', 'Role Access', NULL, NULL),
(3, 'USER_ACCESS', 'USER_ACCESS', NULL, NULL),
(4, 'SOURCES_ACCESS', 'SOURCES ACCESS', NULL, NULL),
(5, 'LEADS_CREATE', 'LEADS CREATE', NULL, NULL),
(6, 'LEADS_EDIT', 'LEADS EDIT', NULL, NULL),
(7, 'LEADS_ACCESS', 'LEADS ACCESS', NULL, NULL),
(8, 'DASHBOARD_ACCESS', 'DASHBOARD ACCESS', NULL, NULL),
(9, 'LEADS_COMMENT_ACCESS', 'LEADS COMMENT ACCESS', NULL, NULL),
(10, 'ANALITICS_ACCESS', 'ANALITICS ACCESS', NULL, NULL),
(11, 'TASKS_VIEW', 'TASKS VIEW', NULL, NULL),
(12, 'TASKS_CREATE', 'TASKS CREATE', NULL, NULL),
(13, 'TASKS_EDIT', 'TASKS EDIT', NULL, NULL),
(14, 'TASKS_COMMENT_VIEW', 'TASKS COMMENT VIEW', NULL, NULL),
(15, 'TASKS_COMMENT_CREATE', 'TASKS COMMENT CREATE', NULL, NULL),
(16, 'TASKS_COMMENT_EDIT', 'TASKS COMMENT EDIT', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `permission_menu`
--

CREATE TABLE `permission_menu` (
  `permission_id` int UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permission_menu`
--

INSERT INTO `permission_menu` (`permission_id`, `menu_id`) VALUES
(1, 9),
(1, 12),
(1, 3),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 11),
(1, 10),
(1, 12);

-- --------------------------------------------------------

--
-- Структура таблицы `permission_role`
--

CREATE TABLE `permission_role` (
  `id` int UNSIGNED NOT NULL,
  `role_id` int UNSIGNED NOT NULL,
  `permission_id` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `permission_role`
--

INSERT INTO `permission_role` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(3, 3, 1, NULL, NULL),
(5, 2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` int UNSIGNED NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `alias`, `title`, `created_at`, `updated_at`) VALUES
(2, 'SUPER_ADMINISTRATOR', 'Super Administrator', '2020-12-13 10:37:02', '2020-12-13 10:37:02'),
(3, 'MANAGER', 'Manager', '2020-12-13 10:51:57', '2020-12-13 10:51:57');

-- --------------------------------------------------------

--
-- Структура таблицы `role_user`
--

CREATE TABLE `role_user` (
  `id` int UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `role_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `role_user`
--

INSERT INTO `role_user` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, NULL),
(2, 2, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `sources`
--

CREATE TABLE `sources` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sources`
--

INSERT INTO `sources` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'Instagram', NULL, '2020-12-26 14:14:27'),
(2, 'Viber', NULL, '2021-09-03 04:27:24'),
(3, 'Site', NULL, NULL),
(4, 'Phone', NULL, NULL),
(9, 'test', '2021-09-03 04:47:42', '2021-09-03 04:47:42');

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE `statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_ru` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`id`, `title`, `title_ru`, `created_at`, `updated_at`) VALUES
(1, 'new', 'Новые заявки', NULL, NULL),
(2, 'process', 'В работе', NULL, NULL),
(3, 'done', 'Выполнено', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint UNSIGNED NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` bigint UNSIGNED DEFAULT NULL,
  `unit_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `responsible_id` bigint UNSIGNED DEFAULT NULL,
  `status_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tasks`
--

INSERT INTO `tasks` (`id`, `phone`, `link`, `source_id`, `unit_id`, `user_id`, `responsible_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, NULL, 'http://gogole.com', 1, 1, 1, 2, 2, '2021-01-31 06:34:15', '2021-08-30 02:06:35'),
(2, NULL, 'http://gogole.com', 1, 1, 1, 1, 3, '2021-01-31 06:35:12', '2021-08-30 02:12:21'),
(3, NULL, 'http://gogole.com', 1, 1, 1, 1, 3, '2021-01-27 06:35:37', '2021-01-28 07:02:49'),
(4, NULL, 'http://gogole1.com', 1, 1, 1, 1, 3, '2021-01-31 08:19:49', '2021-01-31 08:26:04'),
(5, NULL, 'http://ya.ru', 1, 1, 1, 1, 1, '2021-08-12 02:20:23', '2021-08-12 02:20:23'),
(6, NULL, 'http://agular.io', 2, 3, 1, 2, 1, '2021-08-20 04:26:51', '2021-08-20 04:26:51');

-- --------------------------------------------------------

--
-- Структура таблицы `task_comments`
--

CREATE TABLE `task_comments` (
  `id` bigint UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `task_id` bigint UNSIGNED DEFAULT NULL,
  `status_id` bigint UNSIGNED DEFAULT NULL,
  `comment_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_event` tinyint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `task_comments`
--

INSERT INTO `task_comments` (`id`, `text`, `user_id`, `task_id`, `status_id`, `comment_value`, `created_at`, `updated_at`, `is_event`) VALUES
(1, 'Автор  admin создал адачу со статусом Новые заявки', 1, 3, 1, NULL, '2021-01-31 06:35:37', '2021-01-31 06:35:37', 1),
(2, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New Task', 1, 3, 1, 'New Task', '2021-01-31 06:35:37', '2021-01-31 06:35:37', 0),
(3, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на В работе', 1, 2, 2, NULL, '2021-01-31 06:59:52', '2021-01-31 06:59:52', 1),
(4, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment', 1, 2, 2, 'New comment', '2021-01-31 06:59:52', '2021-01-31 06:59:52', 0),
(5, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 2, 3, NULL, '2021-01-31 07:00:07', '2021-01-31 07:00:07', 1),
(6, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 2, 3, 'New comment3', '2021-01-31 07:00:07', '2021-01-31 07:00:07', 0),
(7, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 3, 3, NULL, '2021-01-31 07:01:50', '2021-01-31 07:01:50', 1),
(8, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-01-31 07:01:50', '2021-01-31 07:01:50', 0),
(9, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 3, 3, NULL, '2021-01-31 07:02:49', '2021-01-31 07:02:49', 1),
(10, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-01-31 07:02:49', '2021-01-31 07:02:49', 0),
(11, 'Автор  admin создал адачу со статусом Новые заявки', 1, 4, 1, NULL, '2021-01-31 08:19:49', '2021-01-31 08:19:49', 1),
(12, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New Task', 1, 4, 1, 'New Task', '2021-01-31 08:19:49', '2021-01-31 08:19:49', 0),
(13, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-01-31 08:25:43', '2021-01-31 08:25:43', 0),
(14, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 4, 3, NULL, '2021-01-31 08:26:04', '2021-01-31 08:26:04', 1),
(15, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 4, 3, 'New comment3', '2021-01-31 08:26:04', '2021-01-31 08:26:04', 0),
(16, 'Автор  admin создал адачу со статусом Новые заявки', 1, 5, 1, NULL, '2021-08-12 02:20:23', '2021-08-12 02:20:23', 1),
(17, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New', 1, 5, 1, 'New', '2021-08-12 02:20:23', '2021-08-12 02:20:23', 0),
(18, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-08-12 20:49:19', '2021-08-12 20:49:19', 0),
(19, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-08-12 21:42:30', '2021-08-12 21:42:30', 0),
(20, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> New comment3', 1, 3, 3, 'New comment3', '2021-08-12 21:51:09', '2021-08-12 21:51:09', 0),
(21, 'Автор  admin создал адачу со статусом Новые заявки', 1, 6, 1, NULL, '2021-08-20 04:26:51', '2021-08-20 04:26:51', 1),
(22, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> testComment', 1, 6, 1, 'testComment', '2021-08-20 04:26:51', '2021-08-20 04:26:51', 0),
(23, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на В работе', 1, 1, 2, NULL, '2021-08-30 02:06:35', '2021-08-30 02:06:35', 1),
(24, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> afdfgsdffgh', 1, 1, 2, 'afdfgsdffgh', '2021-08-30 02:06:35', '2021-08-30 02:06:35', 0),
(25, 'Пользователь <strong> admin</strong> изменил <strong>статус</strong> на Выполнено', 1, 2, 3, NULL, '2021-08-30 02:12:21', '2021-08-30 02:12:21', 1),
(26, 'Пользователь <strong> admin</strong> оставил <strong>комментарий</strong> Тест комментария', 1, 2, 3, 'Тест комментария', '2021-08-30 02:12:21', '2021-08-30 02:12:21', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `task_status`
--

CREATE TABLE `task_status` (
  `id` bigint UNSIGNED NOT NULL,
  `task_id` bigint UNSIGNED DEFAULT NULL,
  `status_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `task_status`
--

INSERT INTO `task_status` (`id`, `task_id`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, NULL),
(2, 3, 1, NULL, NULL),
(3, 2, 2, NULL, NULL),
(4, 2, 3, NULL, NULL),
(5, 3, 3, NULL, NULL),
(6, 3, 3, NULL, NULL),
(7, 4, 1, NULL, NULL),
(8, 4, 3, NULL, NULL),
(9, 5, 1, NULL, NULL),
(10, 6, 1, NULL, NULL),
(11, 1, 2, NULL, NULL),
(12, 2, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `units`
--

CREATE TABLE `units` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `units`
--

INSERT INTO `units` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'Shop 1', NULL, NULL),
(2, 'Shop 2', NULL, NULL),
(3, 'Shop 3', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `firstname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `phone`, `password`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin@admin.com', '111111111111', '$2y$10$LEMd3STESyA42mGcPx4ikOXUW06tvHwaOBGaZJh6ezkV1pde5QGX6', '1', NULL, NULL),
(2, 'Manager', 'Manager', 'manager@manager.com', '1234567890', '$2y$10$Z0x9xA6GSDAauXK7syKyvuRVTxaqoEl5Qyl5a97yk8mJZD9EBjJEW', '0', '2020-12-26 07:04:23', '2020-12-26 07:22:03');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Индексы таблицы `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leads_source_id_foreign` (`source_id`),
  ADD KEY `leads_unit_id_foreign` (`unit_id`),
  ADD KEY `leads_user_id_foreign` (`user_id`),
  ADD KEY `leads_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `lead_comments`
--
ALTER TABLE `lead_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_comments_user_id_foreign` (`user_id`),
  ADD KEY `lead_comments_lead_id_foreign` (`lead_id`),
  ADD KEY `lead_comments_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `lead_status`
--
ALTER TABLE `lead_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_status_lead_id_foreign` (`lead_id`),
  ADD KEY `lead_status_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Индексы таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Индексы таблицы `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Индексы таблицы `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `permission_menu`
--
ALTER TABLE `permission_menu`
  ADD KEY `permission_menu_permission_id_foreign` (`permission_id`),
  ADD KEY `permission_menu_menu_id_foreign` (`menu_id`);

--
-- Индексы таблицы `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`),
  ADD KEY `permission_role_permission_id_foreign` (`permission_id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`),
  ADD KEY `role_user_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `sources`
--
ALTER TABLE `sources`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_source_id_foreign` (`source_id`),
  ADD KEY `tasks_unit_id_foreign` (`unit_id`),
  ADD KEY `tasks_user_id_foreign` (`user_id`),
  ADD KEY `tasks_responsible_id_foreign` (`responsible_id`),
  ADD KEY `tasks_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `task_comments`
--
ALTER TABLE `task_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_comments_task_id_foreign` (`task_id`),
  ADD KEY `task_comments_status_id_foreign` (`status_id`),
  ADD KEY `task_comments_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `task_status`
--
ALTER TABLE `task_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_status_task_id_foreign` (`task_id`),
  ADD KEY `task_status_status_id_foreign` (`status_id`);

--
-- Индексы таблицы `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `leads`
--
ALTER TABLE `leads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `lead_comments`
--
ALTER TABLE `lead_comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT для таблицы `lead_status`
--
ALTER TABLE `lead_status`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT для таблицы `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `sources`
--
ALTER TABLE `sources`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `task_comments`
--
ALTER TABLE `task_comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `task_status`
--
ALTER TABLE `task_status`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leads_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leads_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leads_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `lead_comments`
--
ALTER TABLE `lead_comments`
  ADD CONSTRAINT `lead_comments_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  ADD CONSTRAINT `lead_comments_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `lead_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `lead_status`
--
ALTER TABLE `lead_status`
  ADD CONSTRAINT `lead_status_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  ADD CONSTRAINT `lead_status_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`);

--
-- Ограничения внешнего ключа таблицы `permission_menu`
--
ALTER TABLE `permission_menu`
  ADD CONSTRAINT `permission_menu_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_menu_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_responsible_id_foreign` FOREIGN KEY (`responsible_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tasks_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`),
  ADD CONSTRAINT `tasks_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `tasks_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `task_comments`
--
ALTER TABLE `task_comments`
  ADD CONSTRAINT `task_comments_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `task_comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`),
  ADD CONSTRAINT `task_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `task_status`
--
ALTER TABLE `task_status`
  ADD CONSTRAINT `task_status_status_id_foreign` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `task_status_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
