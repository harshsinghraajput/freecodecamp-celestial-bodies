--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\connect universe

SET default_tablespace = '';
SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name character varying(50) UNIQUE NOT NULL,
    galaxy_type text NOT NULL,
    age_in_millions_of_years integer NOT NULL,
    is_spherical boolean NOT NULL,
    distance_from_earth numeric(10,2)
);

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id SERIAL PRIMARY KEY,
    name character varying(50) UNIQUE NOT NULL,
    galaxy_id integer NOT NULL,
    spectral_type character varying(10) NOT NULL,
    has_planets boolean NOT NULL,
    temperature_kelvin integer
);

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id SERIAL PRIMARY KEY,
    name character varying(50) UNIQUE NOT NULL,
    star_id integer NOT NULL,
    has_life boolean NOT NULL,
    orbital_period_days integer NOT NULL
);

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id SERIAL PRIMARY KEY,
    name character varying(50) UNIQUE NOT NULL,
    planet_id integer NOT NULL,
    radius_km integer NOT NULL,
    is_tidal_locked boolean NOT NULL
);

--
-- Name: space_agency; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.space_agency (
    space_agency_id SERIAL PRIMARY KEY,
    name character varying(50) UNIQUE NOT NULL,
    country character varying(50) NOT NULL,
    founded_year integer NOT NULL
);

--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy (galaxy_id, name, galaxy_type, age_in_millions_of_years, is_spherical, distance_from_earth) VALUES 
(1, 'Milky Way', 'Spiral', 13600, false, 0.00),
(2, 'Andromeda', 'Spiral', 10000, false, 2.54),
(3, 'Triangulum', 'Spiral', 12000, false, 2.73),
(4, 'Sombrero', 'Lenticular', 13000, true, 28.00),
(5, 'Centaurus A', 'Elliptical', 11000, true, 11.00),
(6, 'Messier 87', 'Elliptical', 13200, true, 53.00);

--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star (star_id, name, galaxy_id, spectral_type, has_planets, temperature_kelvin) VALUES 
(1, 'Sun', 1, 'G2V', true, 5778),
(2, 'Sirius', 1, 'A1V', false, 9940),
(3, 'Alpha Centauri A', 1, 'G2V', true, 5790),
(4, 'Alpheratz', 2, 'B8IV', false, 13800),
(5, 'Mirach', 2, 'M0III', true, 3800),
(6, 'Veritas', 3, 'O5V', true, 40000);

--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet (planet_id, name, star_id, has_life, orbital_period_days) VALUES 
(1, 'Mercury', 1, false, 88),
(2, 'Venus', 1, false, 225),
(3, 'Earth', 1, true, 365),
(4, 'Mars', 1, false, 687),
(5, 'Jupiter', 1, false, 4333),
(6, 'Saturn', 1, false, 10759),
(7, 'Proxima b', 3, false, 11),
(8, 'Andromedae b', 5, false, 5),
(9, 'Trianguli c', 6, false, 1500),
(10, 'Kepler-186f', 1, false, 130),
(11, 'Uranus', 1, false, 30687),
(12, 'Neptune', 1, false, 60190);

--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon (moon_id, name, planet_id, radius_km, is_tidal_locked) VALUES 
(1, 'Moon', 3, 1737, true),
(2, 'Phobos', 4, 11, true),
(3, 'Deimos', 4, 6, true),
(4, 'Io', 5, 1821, true),
(5, 'Europa', 5, 1560, true),
(6, 'Ganymede', 5, 2634, true),
(7, 'Callisto', 5, 2410, true),
(8, 'Mimas', 6, 198, true),
(9, 'Enceladus', 6, 252, true),
(10, 'Tethys', 6, 531, true),
(11, 'Dione', 6, 561, true),
(12, 'Rhea', 6, 763, true),
(13, 'Titan', 6, 2574, true),
(14, 'Iapetus', 6, 734, true),
(15, 'Ariel', 11, 578, true),
(16, 'Umbriel', 11, 584, true),
(17, 'Titania', 11, 788, true),
(18, 'Oberon', 11, 761, true),
(19, 'Miranda', 11, 235, true),
(20, 'Triton', 12, 1353, true);

--
-- Data for Name: space_agency; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.space_agency (space_agency_id, name, country, founded_year) VALUES 
(1, 'NASA', 'USA', 1958),
(2, 'ESA', 'Europe', 1975),
(3, 'ISRO', 'India', 1969);

--
-- Adjust Sequence Values
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);
SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);
SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);
SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);
SELECT pg_catalog.setval('public.space_agency_space_agency_id_seq', 3, true);

--
-- Constraints and Foreign Keys
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);
