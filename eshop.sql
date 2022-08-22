-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Furniture', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Bed&Mattresses', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Storage', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Appliances', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26', 'Longue Chairs', 'https://ii2.pepperfry.com/media/catalog/product/l/e/494x544/leon-lounge-chair-in-teal-green-colour-by-arra-leon-lounge-chair-in-teal-green-colour-by-arra-yeuanp.jpg','Leon Lounge Chair in Teal Green Colour', 90.00, 0, 05, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Dining Sets', 'https://ii1.pepperfry.com/media/catalog/product/n/o/800x880/noyes-solid-wood-4-seater-dining-set-in-blue---natural-finish-by-amberville-noyes-solid-wood-4-seate-yxvkzg.jpg','Noyes Solid Wood 4 Seater Dining Set In Blue & Natural Finish', 450.00, 0, 12, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Coffee Table', 'https://ii2.pepperfry.com/media/catalog/product/p/e/494x544/petunia-solid-wood-coffee-table-with-marble-top-in-rustic-teak-finish---mudramark-by-pepperfry-petun-78zpaf.jpg', 'Petunia Teak Wood Coffee Table With Marble Top In Rustic Teak Finish', 36.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-06-23 23:03:26', 'Romania Knitted Pouffe in Beige Colour', 'https://ii3.pepperfry.com/media/catalog/product/r/o/494x544/romania-knitted-pouffe-in-beige-colour-by-riance-creations-romania-knitted-pouffe-in-beige-colour-by-gvizbx.jpg', 'Solid Color Pouffes', 120.00, 0, 30, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF005', 0, '2022-06-23 23:03:26', 'Torino LHS L Shaped Chesterfield Sofa Cum Bed With Storage In Fossil Grey Colour', 'https://ii3.pepperfry.com/media/catalog/product/t/o/494x544/torino-2-seater-lhs-sectional-sofa-with-storage-in-fossil-grey-finish-by-vittoria-torino-2-seater-lh-trmviz.jpg', 'Sofa Cum Beds', 320.00, 0, 30, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'Spring Decor Single Bed Foam Mattress', 'https://5.imimg.com/data5/UX/XG/SU/SELLER-68682190/white-foam-mattress-500x500.jpg', 'Excellent Bed Foam Mattress', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Bed Mattress', 'https://www.homestratosphere.com/wp-content/uploads/2017/07/Mattress-on-bed-nov5-18.jpg', 'Comfy Mattress', 67.00, 0, 29, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'Captain kids single bed', 'https://cdn2.bigcommerce.com/n-zfvgw8/5we8xhde/product_images/uploaded_images/twin-bed-10.jpg', 'Single Bed for kids', 89.00, 0, 12, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-06-23 23:03:26', 'White Bed Foam Mattresses, Size: 4 X 6 Feet', 'https://5.imimg.com/data5/ME/KR/MY-49681199/spine-tech-foam-mattresses-500x500.jpg', 'Bed Comfy Foam Mattress', 52.00, 0, 42, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS005', 1, '2022-06-23 23:03:26', 'Floor bedding ideas', 'https://img2.domino.com/dom/image/upload/w_1200,h_630,c_fill,q_auto:best,g_auto:faces/i/floor-bed-ideas-domino-8.jpg', 'Floor Elegant Mattress', 59.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS006', 1, '2022-06-23 23:03:26', 'Beds Archives - American Beds in 2022', 'https://i.pinimg.com/474x/6f/18/13/6f181370e15b69b7cc5bc05200a66048.jpg', 'Stylish Beds For Couples', 76.00, 0, 49, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS007', 1, '2022-06-23 23:03:26', 'Best Rollaway Beds of 2022', 'https://www.thespruce.com/thmb/Znm6dAq1acT36_-378bDHVIEEfM=/fit-in/1500x1500/filters:no_upscale():max_bytes(150000):strip_icc()/leisuitbestrollawaybeds-767dd9955b124aa59ef268119ebdf49e.jpg', 'Rollaway Beds', 90.00, 0, 71, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', 'Wenge Engineered Wood Braine Cornor Wall Shelf', 'https://ii2.pepperfry.com/media/catalog/product/w/e/494x544/wenge-engineered-wood-braine-cornor-wall-shelf-by-bluewud-wenge-engineered-wood-braine-cornor-wall-s-vbqefk.jpg', 'Corner Wall Shelves', 100.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'Sheesham Wood Wall shelf in Honey Oak Finish', 'https://ii1.pepperfry.com/media/catalog/product/b/r/494x544/brown-sheesham-wood-wall-shelf-by-wooden-mode-brown-sheesham-wood-wall-shelf-by-wooden-mode-rjcokk.jpg', 'Cubical Wall Shelves', 80.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Sheesham Wood Book Shelf in Provincial Teak Finish', 'https://ii1.pepperfry.com/media/catalog/product/p/r/494x544/provincial-teak-mango-wood-wall-shelf-by-woodsworth-provincial-teak-mango-wood-wall-shelf-by-woodswo-ryr2aq.jpg', 'Traditional Wall Shelves', 120.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-06-23 23:03:26', 'Sun & Moon Wardrobe with Drawer Storage in Multicolour', 'https://ii2.pepperfry.com/media/catalog/product/s/u/494x544/sun---moon-two-door-wardrobe-in-yellowby-boingg!---a-happy-start-sun---moon-two-door-wardrobe-in-yel-5xgupk.jpg', 'Engineered Wood Wardrobes', 240.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA005', 2, '2022-06-23 23:03:26', 'Wakefit Eliot Engineered Wood Bookshelf, Matte Finish, Dark Walnut (5 Shelves)', 'https://m.media-amazon.com/images/I/61WxQmk9GzL._SL1000_.jpg', 'Kura Book Shelf In Urban Walnut Finish', 200.00, 0, 40, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'Samsung Refrigerator', 'https://ii3.pepperfry.com/media/catalog/product/s/a/494x544/samsung-865l-frost-free-inverter-technology-french-door-refrigerator--flexzone--rf87a9770sg-tl--sams-dbbx5n.jpg','Samsung 865L Frost Free Inverter Technology French Door Refrigerator ', 560.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'Robotic vaccum cleaner', 'https://ii1.pepperfry.com/media/catalog/product/l/i/800x880/life-b5-max-robot-vacuum-with-wi-fi-support--vacuum--mop-and-self-charging-life-b5-max-robot-vacuum--e7tezl.jpg','ILIFE B5 Max Robot Vacuum with Wi-Fi Support, Vacuum, Mop and Self-Charging', 150.00, 0, 26, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'Crompton ceiling Fans', 'https://ii1.pepperfry.com/media/catalog/product/c/r/800x880/crompton-silent-pro-enso-1225-mm--48-inch--activ-bldc-remote-controlled-ceiling-fan--silk-white--cro-p1v4gw.jpg','Crompton Silent Pro Enso 1225 mm (48 inch) Activ BLDC Remote controlled Ceiling Fan (Silk White)', 65.00, 0, 30, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-06-23 23:03:26', 'Air Conditioner', 'https://ii1.pepperfry.com/media/catalog/product/s/a/800x880/samsung-1-5t-3-star-windfree--split-ac-ar18by3arwk--5-00kw--samsung-1-5t-3-star-windfree--split-ac-a-gm4a6i.jpg','Samsung 1.5T 3 Star WindFree Split AC AR18BY3ARWK (5.00kW)', 340.00, 0, 05, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF005', 3, '2022-06-23 23:03:26', 'Air Purifier', 'https://ii1.pepperfry.com/media/catalog/product/s/h/800x880/sharp--fp-f40e-w--dual-purification-air-purifier--plasmacluster-technology--true-hepa-h14-carbon-pre-ccaydb.jpg','Sharp FP-F40E-W Dual Purification Air Purifier (Plasmacluster Technology &True HEPA', 180.00, 0, 15, '2022-06-23 23:03:26');



------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');

CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;